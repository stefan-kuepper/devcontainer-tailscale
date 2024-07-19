#!/bin/sh

sudo -u stefan fish /scripts/bootstrap.fish

/usr/bin/sshd -De
