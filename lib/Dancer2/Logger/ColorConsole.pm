package Dancer2::Logger::ColorConsole;

# ABSTRACT: Console logger with colors
$Dancer2::Logger::ColorConsole::VERSION = '0.001';
use Moo;
use Term::ANSIColor 'color';
use Dancer2::Core::Types 'HashRef';

with 'Dancer2::Core::Role::Logger';

has colors => (
  is      => 'rw',
  isa     => HashRef,
  default => sub {
    {
      debug       => 'bright_green',
      info        => 'magenta',
      warning     => 'yellow',
      error       => 'red',
      core        => 'white',
      default     => 'white',
      app_name    => 'bright_green',
      timestamp   => 'bright_yellow',
      filename    => 'bright_red',
      line_number => 'bright_yellow',
    };
  },
);

sub log {
  my ( $self, $level, $message ) = @_;

  my $color_map = $self->colors;

  $self->log_format( '['
      . color( $color_map->{app_name} ) . '%a:%P'
      . color( $color_map->{default} ) . '] '
      . color( $color_map->{$level} ) . '%L'
      . color( $color_map->{default} ) . ' @'
      . color( $color_map->{timestamp} ) . '%T'
      . color( $color_map->{default} ) . '> '
      . color( $color_map->{$level} ) . '%m'
      . color( $color_map->{default} ) . ' in '
      . color( $color_map->{filename} ) . '%f '
      . color( $color_map->{default} ) . 'l. '
      . color( $color_map->{line_number} ) . '%l'
      . color( $color_map->{default} ) );

  print STDERR $self->format_message( $level => $message );
}

1;
