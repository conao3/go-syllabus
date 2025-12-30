# go-syllabus

A serverless university syllabus API built with Go and AWS SAM.

[![License](https://img.shields.io/github/license/conao3/go-syllabus.svg?style=flat-square)](https://github.com/conao3/go-syllabus/blob/master/LICENSE)
[![Release](https://img.shields.io/github/tag/conao3/go-syllabus.svg?style=flat-square)](https://github.com/conao3/go-syllabus/releases)

## Overview

go-syllabus provides a RESTful API for accessing university syllabus data. The application runs on AWS Lambda with API Gateway, offering a scalable and cost-effective solution for syllabus management.

## Features

- Serverless architecture using AWS Lambda
- RESTful API endpoints via API Gateway
- Custom domain support with SSL/TLS certificates
- Infrastructure as code with AWS SAM templates

## Prerequisites

- [Go](https://golang.org/dl/) 1.x or later
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- [AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
- An AWS account with permissions to create Lambda functions, API Gateway, ACM certificates, and Route53 records

## Project Structure

```
go-syllabus/
├── app/
│   └── lambda/
│       └── hello-world/     # Lambda function source
│           ├── main.go
│           ├── main_test.go
│           ├── go.mod
│           └── go.sum
├── script/
│   └── deploy-syllabus.sh   # Deployment script
├── template.yaml            # SAM template
├── Makefile
└── README.md
```

## Getting Started

### Build

Compile the Lambda functions:

```bash
make build
```

### Deploy

Deploy the application to AWS:

```bash
make deploy
```

This will build the project and run the deployment script, which provisions all necessary AWS resources including:

- Lambda function
- API Gateway with custom domain
- ACM certificate for HTTPS
- Route53 DNS record

### Configuration

Copy the sample environment file and configure your settings:

```bash
cp .env.sample .env
```

Edit `.env` with your domain and AWS configuration values.

## API Endpoints

| Method | Path     | Description         |
|--------|----------|---------------------|
| GET    | `/hello` | Health check endpoint |

## Development

### Running Tests

```bash
cd app/lambda/hello-world
go test -v ./...
```

### Local Testing

Use SAM CLI to test locally:

```bash
sam local start-api
```

Then access the API at `http://localhost:3000/hello`.

## Contributing

Contributions are welcome. Please feel free to submit issues and pull requests.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Author

Naoya Yamashita ([@conao3](https://github.com/conao3))
