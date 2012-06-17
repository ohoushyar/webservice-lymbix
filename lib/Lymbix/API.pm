package Lymbix::API;

use strict;
use warnings;
our $VERSION = '0.01';
$VERSION = eval $VERSION;

use Carp;
use Try::Tiny;
use Mouse;
use LWP::UserAgent;
use HTTP::Request;

=head1 NAME

Lymbix::API - The great new Lymbix::API!

=head1 VERSION

Version 0.01

=cut

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Lymbix::API;

    my $foo = Lymbix::API->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=cut

has api_url => (is => 'rw', isa => 'Str', required => 1, default => 'http://api.lymbix.com/tonalize_detailed');
has auth_key => (is => 'rw', isa => 'Str', required => 1);
has accept_type => (is => 'rw', isa => 'Str', default => 'application/json');
has api_version => (is => 'rw', isa => 'Str', default => '2.2');
has return_fields => (is => 'rw', isa => 'Str');
has article_reference_id => (is => 'rw', isa => 'Str');

has ua => (is => 'rw', isa => 'LWP::UserAgent');
has req => (is => 'rw', isa => 'HTTP::Request');

around BUILDARGS => sub {
    my $orig = shift;
    my $class = shift;

    if (@_ == 1 && !ref $_[0]) {
        return $class->$orig( auth_key => $_[0] );
    } else {
        return $class->$orig(@_);
    }
};

sub BUILD {
    my $self = shift;

    $self->ua(LWP::UserAgent->new);
    $self->req(HTTP::Request->new(POST => $self->api_url));
    $self->req->header(AUTHENTICATION => $self->auth_key);
    $self->req->header(ACCEPT => $self->accept_type);
    $self->req->header(VERSION => $self->api_version);
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

Omid Houshyar, C<< <ohoushyar at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-lymbix-api at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Lymbix-API>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Lymbix::API


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Lymbix-API>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Lymbix-API>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Lymbix-API>

=item * Search CPAN

L<http://search.cpan.org/dist/Lymbix-API/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2012 Omid Houshyar.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

__PACKAGE__->meta->make_immutable();
1;
