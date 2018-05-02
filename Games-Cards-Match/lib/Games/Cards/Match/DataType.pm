package Games::Cards::Match::DataType;

$Games::Cards::Match::DataType::VERSION   = '0.01';
$Games::Cards::Match::DataType::AUTHORITY = 'cpan:MANWAR';

=head1 NAME

Games::Cards::Match::DataType - Placeholder for parameters data type.

=head1 VERSION

Version 0.01

=head1 DESCRIPTION

B<FOR INTERNAL USE ONLY>

=cut

use 5.006;
use strict; use warnings;

use Type::Library -base, -declare => qw(Suit Value Card Rule Cards);
use Types::Standard qw(Str Object ArrayRef);
use Type::Utils;

my $SUITS  = { 'C' => 1, 'D'  => 1, 'H' => 1, 'S' => 1 };
my $VALUES = { 'A' => 1, '2'  => 1, '3' => 1, '4' => 1,
               '5' => 1, '6'  => 1, '7' => 1, '8' => 1,
               '9' => 1, '10' => 1, 'J' => 1, 'Q' => 1,
               'K' => 1 };

declare 'Rule',
    as Str,
    where   { ($_[0] eq 'both') || ($_[0] eq 'suit') || ($_[0] eq 'value') },
    message { "isa check for 'Rule' failed." };

declare 'Suit',
    as Str,
    where   { exists $SUITS->{uc($_[0])} },
    message { "isa check for 'suit' failed." };

declare 'Value',
    as Str,
    where   { exists $VALUES->{uc($_[0])} },
    message { "isa check for 'value' failed." };

declare 'Card',
    as Object,
    where   { ref($_[0]) eq 'Games::Cards::Match::Card' };

declare 'Cards',
    as ArrayRef[Card],
    message { "isa check for 'cards' failed." };

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=cut

1; # End of Games::Cards::Match::DataType
