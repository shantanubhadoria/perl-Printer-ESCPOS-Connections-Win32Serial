# NAME

Printer::ESCPOS::Connections::Serial - Serial Connection Interface for [Printer::ESCPOS](https://metacpan.org/pod/Printer::ESCPOS) on Windows using [Win32::SerialPort](https://metacpan.org/pod/Win32::SerialPort)

<div>
    <p>
    <img src="https://img.shields.io/badge/perl-5.10+-brightgreen.svg" alt="Requires Perl 5.10+" />
    <a href="https://travis-ci.org/shantanubhadoria/perl-Printer-ESCPOS-Connections-Win32Serial"><img src="https://api.travis-ci.org/shantanubhadoria/perl-Printer-ESCPOS-Connections-Win32Serial.svg?branch=build/master" alt="Travis status" /></a>
    <a href="http://matrix.cpantesters.org/?dist=Printer-ESCPOS-Connections-Win32Serial%200.001"><img src="https://badgedepot.code301.com/badge/cpantesters/Printer-ESCPOS-Connections-Win32Serial/0.001" alt="CPAN Testers result" /></a>
    <a href="http://cpants.cpanauthors.org/dist/Printer-ESCPOS-Connections-Win32Serial-0.001"><img src="https://badgedepot.code301.com/badge/kwalitee/Printer-ESCPOS-Connections-Win32Serial/0.001" alt="Distribution kwalitee" /></a>
    <a href="https://gratipay.com/shantanubhadoria"><img src="https://img.shields.io/gratipay/shantanubhadoria.svg" alt="Gratipay" /></a>
    </p>
</div>

# VERSION

version 0.001

# ATTRIBUTES

## portName 

The _portName_ maps to both the Registry Device Name and the Properties associated with that device. A single Physical port can be accessed using two or more Device Names. But the options and setup data will differ significantly in the two cases. A typical example is a Modem on port **COM2**. Source : [Win32::SerialPort](https://metacpan.org/pod/Win32::SerialPort)

## baudrate

When used as a local serial device you can set the baudrate of the printer too. Default (38400) will usually work, but not always. 

This param may be specified when creating printer object to make sure it works properly.

$printer = Printer::Thermal->new(deviceFilePath => '/dev/ttyACM0', baudrate => 9600);

## readConstTime

Seconds per unfulfilled read call, default 150 

## serialOverUSB

Set this value to 1 if you are connecting your printer using the USB Cable but it shows up as a serial device

# METHODS

## read

Read Data from the printer 

## print

Sends buffer data to the printer.

# SUPPORT

## Bugs / Feature Requests

Please report any bugs or feature requests through github at 
[https://github.com/shantanubhadoria/perl-printer-escpos-connections-win32serial/issues](https://github.com/shantanubhadoria/perl-printer-escpos-connections-win32serial/issues).
You will be notified automatically of any progress on your issue.

## Source Code

This is open source software.  The code repository is available for
public review and contribution under the terms of the license.

[https://github.com/shantanubhadoria/perl-printer-escpos-connections-win32serial](https://github.com/shantanubhadoria/perl-printer-escpos-connections-win32serial)

    git clone git://github.com/shantanubhadoria/perl-printer-escpos-connections-win32serial.git

# AUTHOR

Shantanu Bhadoria <shantanu@cpan.org> [https://www.shantanubhadoria.com](https://www.shantanubhadoria.com)

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Shantanu Bhadoria.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
