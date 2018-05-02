package Games::Cards::Match;

$Games::Cards::Match::VERSION   = '0.01';
$Games::Cards::Match::AUTHORITY = 'cpan:MANWAR';

=head1 NAME

Games::Cards::Match - Interface to the Match Card Game.

=head1 VERSION

Version 0.01

=cut

use 5.006;
use List::Util qw(shuffle);
use Types::Standard qw(Int Bool);
use Games::Cards::Match::Card;
use Games::Cards::Match::Player;
use Games::Cards::Match::DataType qw(Cards Rule);

use Moo;
use namespace::autoclean;

has 'active'    => (is => 'rw');
has 'human'     => (is => 'rw');
has 'computer'  => (is => 'rw');
has 'available' => (is => 'ro', isa => Cards);
has 'packs'     => (is => 'ro', isa => Int,  default => sub { 1      });
has 'debug'     => (is => 'rw', isa => Bool, default => sub { 0      });
has 'rules'     => (is => 'ro', isa => Rule, default => sub { 'both' });

sub BUILD {
    my ($self) = @_;

    my $cards = [];
    my $packs = $self->packs;
    while ($packs >=1 ) {
        foreach my $suit (qw(C D H S)) {
            foreach my $value (qw(A 2 3 4 5 6 7 8 9 10 J Q K)) {
                push @$cards, Games::Cards::Match::Card->new({ suit => $suit, value => $value });
            }
        }
        $packs--;
    }

    $self->{available} = [shuffle @{$cards}];

    $self->{human}    = Games::Cards::Match::Player->new({ code => 'H' });
    $self->{computer} = Games::Cards::Match::Player->new({ code => 'C' });
    $self->{active}   = $self->{human};
}

=head1 DESCRIPTION

=head1 METHODS

=head2 play()

Start the game with 'active' player first. Keep picking pairs of cards until
mismatched pairs picked by the player.

=cut

sub play {
    my ($self) = @_;

    my $found_matching = 1;
    while ($found_matching) {
        my $card1 = shift @{$self->{available}};
        my $card2 = shift @{$self->{available}};

        if (defined $card1
            && defined $card2
            && $card1->is_same($card2, $self->{rules})) {
            $self->{active}->save([$card1, $card2]);
        }
        else {
            $found_matching = 0;
        }
    }
}

=head2 next_player()

Make next player active.

=cut

sub next_player {
    my ($self) = @_;

    if ($self->active->code eq 'H') {
        $self->active($self->computer);
    }
    else {
        $self->active($self->human);
    }
}

=head2 is_over()

Returns 1 or 0 depending if the deck is empty or not.

=cut

sub is_over {
    my ($self) = @_;

    return (scalar(@{$self->{available}}) == 0);
}

=head2 final_score()

Returns the final score.

=cut

sub final_score {
    my ($self) = @_;

    my $human    = $self->human->score;
    my $computer = $self->computer->score;
    return sprintf("[H]: %d\n[C]: %d\n\n", $human, $computer);
}

=head2 result()

Declare the result.

=cut

sub result {
    my ($self) = @_;

    my $human    = $self->human->score;
    my $computer = $self->computer->score;
    if ($human > $computer) {
        return "You are the winner, congratulations.";
    }
    elsif ($human < $computer) {
        return "Computer beat you this time, sorry.";
    }
    else {
        return "Game drawn.";
    }
}

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=cut

1; # End of Games::Cards::Match
