# SWE645 – Assignment 1
**Author:** Yi Feng Huang
**G Number:** G01532343
**Course:** SWE 645 – Component-Based Software Development
**Semester:** Summer 2025

---

## Live URLs
| Deployment | URL |
|---|---|
| S3 Static Site | `http://swe645-yihuang40-hw1.s3-website-us-east-1.amazonaws.com/` |
| EC2 Web Server | `http://54.204.134.181` |

---

## Source Files
| File | Purpose |
|---|---|
| `index.html` | Class homepage |
| `survey.html` | Student Survey form |
| `about.html` | About page |
| `resume.html` | Resume page |
| `services.html` | Services page |
| `error.html` | 404 error page |
| `assets/` | CSS, JS, images (FolioOne Bootstrap template) |

---

## Part A – AWS S3 Deployment

1. Go to AWS Console → S3 → **Create bucket** (name: `swe645-yihuang40-hw1`, region: `us-east-1`)
2. Uncheck **Block all public access** → Save
3. Go to **Properties** → **Static website hosting** → Enable → Index: `index.html`, Error: `error.html`
4. Go to **Permissions** → **Bucket policy** → Add:
```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::swe645-yihuang40-hw1/*"
  }]
}
```
5. Upload all files and `assets/` folder → Done

---

## Part B – AWS EC2 Deployment

1. Go to AWS Console → EC2 → **Launch instance**
   - AMI: Amazon Linux 2023, Type: t2.micro
   - Security group: allow SSH (22) and HTTP (80)
   - Create key pair → download `.pem`
2. Connect via SSH:
```bash
chmod 400 swe645.pem
ssh -i swe645-key.pem ec2-user@54.204.134.181
```
3. Install Apache:
```bash
sudo dnf update -y
sudo dnf install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
```
4. Upload files from local machine:
```bash
scp -i swe645-key.pem -r index.html survey.html about.html resume.html services.html error.html assets/ ec2-user@54.204.134.181:/home/ec2-user/
```
5. Copy to Apache web root:
```bash
sudo cp -r /home/ec2-user/* /var/www/html/
sudo chmod -R 755 /var/www/html/
```
6. Open `http://54.204.134.181` to verify
