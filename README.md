# Online Analysis TV (OATV) Installation Guide

This guide assumes OATV application will be installed on CentOS 7 server.

## Prerequisites

Before installing, you must have access to a superuser account (either direct or via SSH) on a CentOS 7 server.

## Installation

OATV application requires Ruby v2.3.0 and Rails v4.2.5. Please refer to [this guide](http://tutorials.pluralsight.com/review/how-to-install-ruby-on-rails-on-centos-7) for basic installation.

After that, let's clone OATV app from git remote repo:
```shell
cd ~
git clone https://github.com/clthck/oatv.git
```

## Additional Setup

### ImageMagick

Since we're using [paperclip](https://github.com/thoughtbot/paperclip) gem on OATV app, we need to install ImageMagick on our CentOS 7 server.
Run the following command to install ImageMagick:
```shell
sudo yum install ImageMagick ImageMagick-devel
```

### Bower

OATV uses bower to manage 3rd party front end assets.
Run the following command to install bower:
```shell
sudo npm install -g bower
```

### Environment Variables

OATV uses environment variables for some configurations.
Run the following commands to set necessary env vars properly.
```shell
echo 'export OATV_RAILS_SERVER_BINDING="your public server IP"' >> ~/.bash_profile
echo 'export OATV_POSTGRES_USERNAME="pg_username"' >> ~/.bash_profile
echo 'export OATV_POSTGRES_PASSWORD="pg_password"' >> ~/.bash_profile
echo 'export OATV_POSTGRES_DATABASE_DEVELOPMENT="oatv_development"' >> ~/.bash_profile
echo 'export OATV_POSTGRES_DATABASE_TEST="oatv_test"' >> ~/.bash_profile
echo 'export OATV_POSTGRES_DATABASE_PRODUCTION="oatv_production"' >> ~/.bash_profile
echo 'export OATV_ACTION_MAILER_HOST="your_servers_public_ip"' >> ~/.bash_profile
echo 'export OATV_YOUTUBE_API_KEY="youtube_api_key"' >> ~/.bash_profile
```

### Final Preparations

```shell
cd ~/oatv
bundle install
bower install
rake db:migrate
rake db:seed
```

## Running OATV

Now we're ready to run OATV application.

### Development Mode

```shell
rails s
```