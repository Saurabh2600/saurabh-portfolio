# Saurabh - AWS Cloud Engineer Portfolio

A modern, professional portfolio website showcasing cloud engineering expertise, projects, certifications, and professional experience.

## 🌟 Features

- **Responsive Design**: Fully responsive across all devices (mobile, tablet, desktop)
- **Dark/Light Mode**: Toggle between themes with persistent preference
- **Visitor Counter**: Simple client-side visitor tracking
- **Downloadable Resume**: One-click resume download functionality
- **Contact Form**: Interactive contact form with validation
- **Smooth Animations**: Scroll-triggered animations and smooth transitions
- **SEO Optimized**: Proper meta tags and semantic HTML
- **Modern UI/UX**: Clean, professional design with vibrant gradients

## 📁 Project Structure

```
Saurabh Portfolio/
├── index.html              # Main HTML file
├── css/
│   └── style.css          # All styles with CSS variables
├── js/
│   └── main.js            # JavaScript functionality
├── images/
│   ├── profile-placeholder.svg
│   ├── project-3tier.svg
│   ├── project-bloodbank.svg
│   └── blog-placeholder.svg
├── README.md              # This file
└── AWS_DEPLOYMENT.md      # AWS deployment guide
```

## 🚀 Quick Start

### Local Development

1. **Clone or download** this repository
2. **Open** `index.html` in your web browser
3. **That's it!** No build process required

### Customization

1. **Update Personal Information**:
   - Edit `index.html` to add your details
   - Replace placeholder images in `/images/` folder
   - Update social media links

2. **Customize Colors**:
   - Edit CSS variables in `css/style.css` (lines 1-50)
   - Change `--primary-color`, `--secondary-color`, etc.

3. **Add Your Resume**:
   - Replace the resume generation function in `js/main.js`
   - Or link to a PDF file

## 🎨 Customization Guide

### Changing Colors

Edit the CSS variables in `css/style.css`:

```css
:root {
    --primary-color: #FF6B35;    /* Main brand color */
    --secondary-color: #004E89;  /* Secondary brand color */
    --accent-color: #F77F00;     /* Accent color */
}
```

### Adding Your Photo

Replace `images/profile-placeholder.svg` with your photo:
- Recommended size: 400x400px
- Format: JPG, PNG, or SVG
- Update the `src` attribute in `index.html`

### Updating Projects

Edit the projects section in `index.html`:
- Add/remove project cards
- Update project descriptions
- Add GitHub/live demo links

### Social Media Links

Update social links in `index.html`:
- LinkedIn: Line ~95
- GitHub: Line ~98
- Twitter: Line ~101
- Email: Line ~104

## 🛠️ Technologies Used

- **HTML5**: Semantic markup
- **CSS3**: Modern styling with CSS Grid, Flexbox, and CSS Variables
- **JavaScript (ES6+)**: Interactive functionality
- **Font Awesome**: Icons
- **Google Fonts**: Inter font family

## 📱 Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

## 🔧 Advanced Features

### Visitor Counter

The current implementation uses `localStorage` for demonstration. For production:
- Use AWS Lambda + DynamoDB
- See `AWS_DEPLOYMENT.md` for implementation details

### Contact Form

Currently logs to console. To make it functional:
- Set up AWS Lambda function
- Configure API Gateway
- Update form submission in `js/main.js`

## 📝 To-Do / Future Enhancements

- [ ] Add blog functionality with CMS
- [ ] Implement real visitor analytics with AWS
- [ ] Add project detail modals
- [ ] Create admin panel for content updates
- [ ] Add testimonials section
- [ ] Implement email notifications for contact form

## 📄 License

This project is open source and available for personal and commercial use.

## 👤 Author

**Saurabh**
- Role: AWS Cloud Engineer
- Company: K21 Technology Pvt. Ltd.

## 🙏 Acknowledgments

- Font Awesome for icons
- Google Fonts for typography
- AWS for hosting infrastructure

---

**Built with ❤️ and deployed on AWS ☁️**
