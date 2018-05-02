package Games::Cards::Match::Card;

$Games::Cards::Match::Card::VERSION   = '0.01';
$Games::Cards::Match::Card::AUTHORITY = 'cpan:MANWAR';

=head1 NAME

Games::Cards::Match::Card - Object representation of a card.

=head1 VERSION

Version 0.01

=cut

use 5.006;
use Games::Cards::Match::DataType qw(Value Suit);

use Moo;
use namespace::autoclean;

has 'suit'  => (is => 'ro', isa => Suit,  required => 1);
has 'value' => (is => 'ro', isa => Value, required => 1);

=head1 DESCRIPTION

B<FOR INTERNAL USE ONLY>.

=head1 METHODS

=head2 is_same($card, $rule)

=cut

sub is_same {
    my ($self, $other, $rule) = @_;

    return 0 unless (defined($other) && (ref($other) eq 'Games::Cards::Match::Card'));
    die "ERROR: Missing rule.\n" unless (defined $rule);

    if ($rule eq 'both') {
        return ((defined($self->{suit})
                 && (defined($other->{suit}))
                 && (lc($self->{suit}) eq lc($other->{suit}))
                )
                ||
                (defined($self->{value})
                 && (defined($other->{value}))
                 && (lc($self->{value}) eq lc($other->{value}))
                ));
    }

    return (defined($self->{$rule})
            && (defined($other->{$rule}))
            && (lc($self->{$rule}) eq lc($other->{$rule})));
}

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=cut

1; # End of Games::Cards::Match::Card
