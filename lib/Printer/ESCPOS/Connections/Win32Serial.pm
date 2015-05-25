use strict;
use warnings;

package Printer::ESCPOS::Connections::Win32Serial;

# PODNAME: Printer::ESCPOS::Connections::Serial
# ABSTRACT: Serial Connection Interface for L<Printer::ESCPOS> on Windows using L<Win32::SerialPort>
#
# This file is part of Printer-ESCPOS-Connections-Win32Serial
#
# This software is copyright (c) 2015 by Shantanu Bhadoria.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
our $VERSION = '0.001'; # VERSION

# Dependencies

use 5.010;
use Moo;
with 'Printer::ESCPOS::Roles::Connection';

use Win32::SerialPort;
use Time::HiRes qw(usleep);


has portName => ( is => 'ro', );


has baudrate => (
    is      => 'ro',
    default => 38400,
);


has readConstTime => (
    is      => 'ro',
    default => 150,
);


has serialOverUSB => (
    is      => 'rw',
    default => '0',
);

has _connection => (
    is       => 'lazy',
    init_arg => undef,
);

sub _build__connection {
    my ($self) = @_;

    my $printer = new Win32::SerialPort( $self->portName )
      || die "Can't open Port: $!\n";

    $printer->databits(8);
    $printer->baudrate( $self->baudrate );
    $printer->parity("none");
    $printer->stopbits(1);
    $printer->handshake("xoff");
    $printer->buffers( 4096, 4096 );
    $printer->baudrate(9600);
    $printer->write_settings || undef $printer;

    $printer->read_const_time( $self->readConstTime )
      ;    # 1 second per unfulfilled "read" call
    $printer->read_char_time(0);    # don't wait for each character

    return $printer;
}


sub read {
    my ( $self, $question, $bytes ) = @_;
    $bytes |= 1024;

    $self->_connection->write($question);
    my ( $count, $data ) = $self->_connection->read($bytes);

    return $data;
}


sub print {
    my ( $self, $raw ) = @_;
    my @chunks;

    my $buffer = $self->_buffer;
    if ( defined $raw ) {
        $buffer = $raw;
    }
    else {
        $self->_buffer('');
    }

    my $n = 8;    # Size of each chunk in bytes
    $n = 64 if ( $self->serialOverUSB );

    @chunks = unpack "a$n" x ( ( length($buffer) / $n ) - 1 ) . "a*", $buffer;
    for my $chunk (@chunks) {
        $self->_connection->write($chunk);
        if ( $self->serialOverUSB ) {
            $self->_connection->read();
        }
        else {
            usleep(10000)
              ; # Serial Port is annoying, it doesn't tell you when it is ready to get the next chunk
        }
    }
}

no Moo;
__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=head1 NAME

Printer::ESCPOS::Connections::Serial - Serial Connection Interface for L<Printer::ESCPOS> on Windows using L<Win32::SerialPort>

=head1 VERSION

version 0.001

=head1 ATTRIBUTES

=head2 portName 

The I<portName> maps to both the Registry Device Name and the Properties associated with that device. A single Physical port can be accessed using two or more Device Names. But the options and setup data will differ significantly in the two cases. A typical example is a Modem on port B<COM2>. Source : L<Win32::SerialPort>

=head2 baudrate

When used as a local serial device you can set the baudrate of the printer too. Default (38400) will usually work, but not always. 

This param may be specified when creating printer object to make sure it works properly.

$printer = Printer::Thermal->new(deviceFilePath => '/dev/ttyACM0', baudrate => 9600);

=head2 readConstTime

Seconds per unfulfilled read call, default 150 

=head2 serialOverUSB

Set this value to 1 if you are connecting your printer using the USB Cable but it shows up as a serial device

=head1 METHODS

=head2 read

Read Data from the printer 

=head2 print

Sends buffer data to the printer.

=for :stopwords cpan testmatrix url annocpan anno bugtracker rt cpants kwalitee diff irc mailto metadata placeholders metacpan

=head1 SUPPORT

=head2 Bugs / Feature Requests

Please report any bugs or feature requests through github at 
L<https://github.com/shantanubhadoria/perl-printer-escpos-connections-win32serial/issues>.
You will be notified automatically of any progress on your issue.

=head2 Source Code

This is open source software.  The code repository is available for
public review and contribution under the terms of the license.

L<https://github.com/shantanubhadoria/perl-printer-escpos-connections-win32serial>

  git clone git://github.com/shantanubhadoria/perl-printer-escpos-connections-win32serial.git

=head1 AUTHOR

Shantanu Bhadoria <shantanu@cpan.org> L<https://www.shantanubhadoria.com>

=head1 CONTRIBUTOR

=for stopwords Shantanu Bhadoria

Shantanu Bhadoria <shantanu@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Shantanu Bhadoria.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
