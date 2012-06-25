package Lymbix::API;

use strict;
use warnings;
our $VERSION = '0.01';
$VERSION = eval $VERSION;

use Carp;
use Try::Tiny;
use Encode;
use Mouse;
use Mouse::Util::TypeConstraints;
use LWP::UserAgent;
use HTTP::Request;

=head1 NAME

Lymbix::API - API wrapper of Lymbix.

=head1 VERSION

Version 0.01

=cut

=head1 SYNOPSIS

An API wrapper of Lymbix. See L<http://lymbix.com> for more details.

Perhaps a little code snippet.

    use Lymbix::API;

    my $auth_key = '<YOURAUTHKEY>';
    my $lymbix = Lymbix::API->new($auth_key);
    print $lymbix->tonalize("if you had to launch your business in two weeks, what would you cut")
    ...

=head1 ATTRIBUTES

=head2 api_url

=head2 auth_key

=head2 accept_type

=head2 api_version



=cut

has api_url => (is => 'rw', isa => 'Str', required => 1, default => 'http://api.lymbix.com');
has auth_key => (is => 'rw', isa => 'Str', required => 1);

enum 'AcceptType' => qw(application/json application/xml);
has accept_type => (
    is => 'rw',
    isa => 'AcceptType',
    default => 'application/json',
);

has api_version => (is => 'rw', isa => 'Str', default => '2.2');

has ua => (is => 'rw', isa => 'LWP::UserAgent');
has req => (is => 'rw', isa => 'HTTP::Request');

has tonalize_uri => (is => 'ro', default => '/tonalize');

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
    $self->req(HTTP::Request->new('POST'));
    $self->req->header(AUTHENTICATION => $self->auth_key);
    $self->req->header(ACCEPT => $self->accept_type);
    $self->req->header(VERSION => $self->api_version);
}

=head1 METHODS

=head2 tonalize(article, [return_fields, accept_type, article_reference_id])

The tonalize method provides article-level Lymbix sentiment data for a single article.

=cut

sub tonalize {
    my $self = shift;

    my $article = shift;
    my $return_fields = shift || '';
    my $reference_id = shift || '';

    $self->req->uri($self->api_url.$self->tonalize_uri);

    my $content = qq(article=$article);
    $content .= qq(&return_fields=[ $return_fields ]);
    $content .= qq(&reference_id=$reference_id);
    $self->req->content( encode("UTF8", $content) );

    return $self->_request;
}

sub _request {
    my $self = shift;

    my $res = $self->ua->request($self->req);
    if ($res->is_success) {
        return $res->content;
    } else {
        return $res->status_line;
    }
}

=head2 PARAMS

=head3 article (string)

=head3 return_fields (csv)

=head3 accept_type (default:application/json application/xml)

=head3 article_reference_id

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
