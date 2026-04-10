# AWS Deployment Guide

Complete guide to deploy your portfolio website on AWS using S3 and CloudFront.

## 🎯 Deployment Architecture

```
User → CloudFront (CDN) → S3 Bucket (Static Website) → Your Portfolio
```

**Benefits**:
- Global content delivery via CloudFront edge locations
- HTTPS/SSL encryption
- High availability and scalability
- Low cost (often under $1/month)
- Fast loading times worldwide

## 📋 Prerequisites

- AWS Account (free tier eligible)
- AWS CLI installed (optional but recommended)
- Your portfolio files ready

## 🚀 Deployment Steps

### Step 1: Create S3 Bucket

1. **Log in to AWS Console** → Navigate to S3

2. **Create Bucket**:
   - Click "Create bucket"
   - Bucket name: `your-name-portfolio` (must be globally unique)
   - Region: Choose closest to your target audience (e.g., `ap-south-1` for India)
   - **Uncheck** "Block all public access" (we'll use CloudFront for security)
   - Click "Create bucket"

3. **Enable Static Website Hosting**:
   - Select your bucket → Properties tab
   - Scroll to "Static website hosting"
   - Click "Edit"
   - Enable: "Static website hosting"
   - Index document: `index.html`
   - Error document: `index.html` (for SPA routing)
   - Save changes
   - **Note the endpoint URL** (e.g., `http://your-bucket.s3-website.ap-south-1.amazonaws.com`)

### Step 2: Upload Website Files

**Option A: AWS Console (Easy)**
1. Go to your bucket → Objects tab
2. Click "Upload"
3. Add all files and folders:
   - `index.html`
   - `css/` folder
   - `js/` folder
   - `images/` folder
   - `README.md`
4. Click "Upload"

**Option B: AWS CLI (Recommended)**
```bash
# Navigate to your portfolio folder
cd "C:\Users\HP\Desktop\Saurabh Portfolio"

# Sync files to S3
aws s3 sync . s3://your-name-portfolio --exclude ".git/*" --exclude "*.md"

# Set proper content types
aws s3 cp s3://your-name-portfolio s3://your-name-portfolio --recursive --exclude "*" --include "*.html" --content-type "text/html" --metadata-directive REPLACE
aws s3 cp s3://your-name-portfolio s3://your-name-portfolio --recursive --exclude "*" --include "*.css" --content-type "text/css" --metadata-directive REPLACE
aws s3 cp s3://your-name-portfolio s3://your-name-portfolio --recursive --exclude "*" --include "*.js" --content-type "application/javascript" --metadata-directive REPLACE
```

### Step 3: Configure Bucket Policy

1. Go to bucket → Permissions tab → Bucket policy
2. Add this policy (replace `your-name-portfolio` with your bucket name):

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::your-name-portfolio/*"
        }
    ]
}
```

3. Save changes

**Test**: Visit your S3 website endpoint to verify it works.

### Step 4: Create CloudFront Distribution

1. **Navigate to CloudFront** in AWS Console

2. **Create Distribution**:
   - Click "Create distribution"
   
3. **Origin Settings**:
   - Origin domain: Select your S3 bucket **website endpoint** (not the bucket itself)
     - Example: `your-bucket.s3-website.ap-south-1.amazonaws.com`
   - Protocol: HTTP only (S3 website endpoints don't support HTTPS)
   - Name: Leave default

4. **Default Cache Behavior**:
   - Viewer protocol policy: "Redirect HTTP to HTTPS"
   - Allowed HTTP methods: GET, HEAD
   - Cache policy: "CachingOptimized"
   - Origin request policy: None

5. **Settings**:
   - Price class: "Use all edge locations" (or choose based on your audience)
   - Alternate domain name (CNAME): Leave empty for now (or add your custom domain)
   - SSL certificate: Default CloudFront certificate
   - Default root object: `index.html`

6. **Create Distribution**
   - Click "Create distribution"
   - **Wait 5-15 minutes** for deployment (Status: "Enabled")
   - **Note your CloudFront domain** (e.g., `d1234abcd.cloudfront.net`)

### Step 5: Test Your Website

1. Visit your CloudFront URL: `https://d1234abcd.cloudfront.net`
2. Test all features:
   - Dark/light mode toggle
   - Navigation
   - Contact form
   - Resume download
   - Mobile responsiveness

## 🌐 Custom Domain Setup (Optional)

### Using Route 53

1. **Register/Transfer Domain** to Route 53 (or use existing domain)

2. **Request SSL Certificate** (AWS Certificate Manager):
   - Navigate to ACM in **us-east-1** region (required for CloudFront)
   - Request public certificate
   - Domain name: `yourdomain.com` and `www.yourdomain.com`
   - Validation: DNS validation
   - Add CNAME records to Route 53 for validation
   - Wait for certificate status: "Issued"

3. **Update CloudFront Distribution**:
   - Edit distribution settings
   - Alternate domain names: `yourdomain.com`, `www.yourdomain.com`
   - SSL certificate: Select your ACM certificate
   - Save changes

4. **Create Route 53 Records**:
   - Go to Route 53 → Hosted zones → Your domain
   - Create A record:
     - Name: Leave empty (for root domain)
     - Type: A
     - Alias: Yes
     - Alias target: Your CloudFront distribution
   - Create another A record for `www`:
     - Name: `www`
     - Type: A
     - Alias: Yes
     - Alias target: Your CloudFront distribution

5. **Wait for DNS propagation** (5-30 minutes)

6. **Test**: Visit `https://yourdomain.com`

## 💰 Cost Estimation

**Free Tier (First 12 months)**:
- S3: 5GB storage, 20,000 GET requests
- CloudFront: 50GB data transfer out, 2,000,000 HTTP requests
- Route 53: $0.50/month per hosted zone (not free)

**After Free Tier** (typical portfolio):
- S3: ~$0.10/month (for ~100MB site)
- CloudFront: ~$1-2/month (for moderate traffic)
- Route 53: $0.50/month (if using custom domain)

**Total**: ~$1-3/month

## 🔄 Updating Your Website

### Method 1: AWS Console
1. Upload new files to S3 bucket
2. Invalidate CloudFront cache:
   - CloudFront → Distributions → Your distribution
   - Invalidations tab → Create invalidation
   - Object paths: `/*`
   - Create

### Method 2: AWS CLI (Recommended)
```bash
# Sync changes
aws s3 sync . s3://your-name-portfolio --delete

# Invalidate CloudFront cache
aws cloudfront create-invalidation --distribution-id YOUR_DISTRIBUTION_ID --paths "/*"
```

## 🔐 Security Best Practices

1. **Use CloudFront Origin Access Control (OAC)**:
   - More secure than public S3 bucket
   - Prevents direct S3 access
   - [AWS Documentation](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html)

2. **Enable CloudFront Security Headers**:
   - Add response headers policy
   - Include: X-Content-Type-Options, X-Frame-Options, X-XSS-Protection

3. **Enable AWS WAF** (optional, for DDoS protection):
   - Attach WAF to CloudFront distribution
   - Create rules for common threats

## 📊 Adding Real Visitor Analytics

### Option 1: AWS Lambda + DynamoDB (Serverless)

**Architecture**: CloudFront → API Gateway → Lambda → DynamoDB

**Steps**:

1. **Create DynamoDB Table**:
   - Table name: `portfolio-visitors`
   - Partition key: `id` (String)
   - Create table

2. **Create Lambda Function**:
   ```python
   import json
   import boto3
   from datetime import datetime
   
   dynamodb = boto3.resource('dynamodb')
   table = dynamodb.Table('portfolio-visitors')
   
   def lambda_handler(event, context):
       # Increment visitor count
       response = table.update_item(
           Key={'id': 'visitor-count'},
           UpdateExpression='ADD visit_count :inc',
           ExpressionAttributeValues={':inc': 1},
           ReturnValues='UPDATED_NEW'
       )
       
       count = response['Attributes']['visit_count']
       
       return {
           'statusCode': 200,
           'headers': {
               'Access-Control-Allow-Origin': '*',
               'Content-Type': 'application/json'
           },
           'body': json.dumps({'count': int(count)})
       }
   ```

3. **Create API Gateway**:
   - REST API
   - Create GET method → Integrate with Lambda
   - Enable CORS
   - Deploy API

4. **Update JavaScript**:
   ```javascript
   async function initVisitorCounter() {
       try {
           const response = await fetch('YOUR_API_GATEWAY_URL');
           const data = await response.json();
           animateCounter(visitorCountElement, 0, data.count, 1500);
       } catch (error) {
           console.error('Error fetching visitor count:', error);
           visitorCountElement.textContent = '---';
       }
   }
   ```

### Option 2: Google Analytics (Simple)

1. Create Google Analytics account
2. Add tracking code to `index.html`:
   ```html
   <!-- Google Analytics -->
   <script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
   <script>
     window.dataLayer = window.dataLayer || [];
     function gtag(){dataLayer.push(arguments);}
     gtag('js', new Date());
     gtag('config', 'G-XXXXXXXXXX');
   </script>
   ```

## 🔧 Troubleshooting

### Issue: CloudFront shows S3 XML error
**Solution**: Use S3 website endpoint as origin, not bucket endpoint

### Issue: Changes not reflecting
**Solution**: Invalidate CloudFront cache

### Issue: HTTPS not working
**Solution**: Ensure CloudFront viewer protocol is "Redirect HTTP to HTTPS"

### Issue: Custom domain not working
**Solution**: Check DNS propagation, verify ACM certificate in us-east-1

## 📚 Additional Resources

- [AWS S3 Static Website Hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
- [CloudFront Documentation](https://docs.aws.amazon.com/cloudfront/)
- [AWS Free Tier](https://aws.amazon.com/free/)
- [AWS CLI Installation](https://aws.amazon.com/cli/)

## 🎓 Learning Path

After deploying, consider:
1. Setting up CI/CD with GitHub Actions
2. Implementing serverless contact form with SES
3. Adding CloudWatch monitoring
4. Implementing AWS Amplify for easier deployments

---

**Need Help?** Check AWS documentation or AWS support forums.

**Deployed Successfully?** 🎉 Share your portfolio and showcase your AWS skills!
