package Games::Cards::Match::Player;

$Games::Cards::Match::Player::VERSION   = '0.01';
$Games::Cards::Match::Player::AUTHORITY = 'cpan:MANWAR';

=head1 NAME

Games::Cards::Match::Player - Represents the player of the Match game.

=head1 VERSION

Version 0.01

=cut

use 5.006;
use Moo;
use namespace::autoclean;

has 'code'  => (is => 'ro', required => 1);
has 'cards' => (is => 'rw', default  => sub { [] });

=head1 DESCRIPTION

B<FOR INTERNAL USE ONLY>.

=head1 METHODS

=head2 save($cards)

Saves the matched cards.

=cut

sub save {
    my ($self, $cards) = @_;

    push @{$self->{cards}}, @$cards;
}

=head2 score()

Returns the total matched cards.

=cut

sub score {
    my ($self) = @_;

    return scalar(@{$self->{cards}});
}

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=cut

1; # End of Games::Cards::Match::Player
