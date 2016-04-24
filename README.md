# AWS CLI Docker Container

Docker container with the AWS CLI installed.

Using [Alpine linux](https://hub.docker.com/_/alpine/).  The Docker image is 30MB

## Getting your AWS Keys:

[http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html#cli-signup](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html#cli-signup)

## Passing your keys into this container via environmental variables:

[http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-environment](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-environment)

## Command line options for things like setting the region

[http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-command-line](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-command-line)

## You can run any commands available to the AWS CLI

[http://docs.aws.amazon.com/cli/latest/index.html](http://docs.aws.amazon.com/cli/latest/index.html)

## Example Usage:

### Describe an instance:

    docker run \
    --env AWS_ACCESS_KEY_ID=<<YOUR_ACCESS_KEY>> \
    --env AWS_SECRET_ACCESS_KEY=<<YOUR_SECRET_ACCESS>> \
    --env AWS_DEFAULT_REGION=us-east-1 \
    garland/aws-cli-docker \
    aws ec2 describe-instances --instance-ids i-90949d7a

output:

    {
        "Reservations": [
            {
                "OwnerId": "960288280607",
                "ReservationId": "r-1bb15137",
                "Groups": [],
                "RequesterId": "226008221399",
                "Instances": [
                    {
                        "Monitoring": {
                            "State": "enabled"
                        },
                        "PublicDnsName": null,
    ...
    ...
    }

### Return a list of items in s3 bucket

    docker run \
    --env AWS_ACCESS_KEY_ID=<<YOUR_ACCESS_KEY>> \
    --env AWS_SECRET_ACCESS_KEY=<<YOUR_SECRET_ACCESS>> \
    garland/aws-cli-docker \
    aws s3 ls

output:

    2014-06-03 19:41:30 folder1
    2014-06-06 23:02:29 folder2

doc: http://docs.aws.amazon.com/cli/latest/reference/s3/index.html

### Retrieve a decrypted Windows password by passing in your private key
We will map the private keys that resides on your local system to inside the container

    docker run \
    -v <<LOCATION_TO_YOUR_PRIVATE_KEYy>>:/tmp/key.pem \
    --env AWS_ACCESS_KEY_ID=<<YOUR_ACCESS_KEY>> \
    --env AWS_SECRET_ACCESS_KEY=<<YOUR_SECRET_ACCESS>> \
    --env AWS_DEFAULT_REGION=us-east-1 \
    garland/aws-cli-docker \
    aws ec2 get-password-data --instance-id  <<YOUR_INSTANCE_ID>> --priv-launch-key /tmp/key.pem

Output:

    {
        "InstanceId": "i-90949d7a",
        "Timestamp": "2014-12-11T01:18:27.000Z",
        "PasswordData": "8pa%o?foo"
    }

doc: http://docs.aws.amazon.com/cli/latest/reference/ec2/get-password-data.html
