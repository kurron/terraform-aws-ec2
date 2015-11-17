#!/bin/bash

IP=$1
ssh -v -i kurr-experiments.pem ubuntu@${IP}
