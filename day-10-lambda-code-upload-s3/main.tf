resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "my_lambda_bucket_ton"
  force_destroy = true
  tags = {
    Name="lambdaaabuckit"
  }
}
# ACL for the S3 bucket
resource "aws_s3_bucket_acl" "lambda_bucket_acl" {
  bucket = aws_s3_bucket.lambda_bucket.id
  acl    = "private"  # Set ACL for the bucket (private, public-read, etc.)
}

resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = "lambda_function.zip"
  source = "lambda_function.zip" # Path to your zip file containing the Lambda code
  etag   = filemd5("lambda_function.zip") 
  
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

  resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = "role = aws_iam_role.lambda_role.arn"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "my_lambda" {
  function_name="my_lambda_function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  timeout       = 900
  memory_size   = 128
  filename         = "lambda_function.zip"  # Ensure this file exists
  source_code_hash = filebase64sha256("lambda_function.zip")
  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key = aws_s3_object.lambda_code.key

  tags = {
    Name="my_lam_function"
  }
}