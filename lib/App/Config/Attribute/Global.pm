package App::Config::Attribute::Global;

use Moose;
extends 'App::Config::Attribute';

=head1 NAME

App::Config::Attribute::Global

=cut

sub _build_value {
    my $self = shift;
    my $value;
    $value //= $self->data_set->{app_settings_overrides}->get($self->path) if ($self->data_set->{app_settings_overrides});
    $value //= $self->data_set->{global}->get($self->path)                 if ($self->data_set->{global});
    $value //= $self->data_set->{app_config}->get($self->path)             if ($self->data_set->{app_config});
    $value //= $self->definition->{default}                                if ($self->definition);

    return $value;
}

sub _set_value {
    my $self  = shift;
    my $value = shift;
    $self->data_set->{global}->set($self->path, $value) if ($self->data_set->{global});
    return;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;