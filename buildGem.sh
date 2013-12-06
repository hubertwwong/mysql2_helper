#!/bin/bash
echo "building gem"
gem build mysql2_helper.gemspec
gem install mysql2_helper-0.0.1.gem