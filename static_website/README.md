## Week 5: Static Website Deployment

- Connecting domains to hosting providers
- Hands-on: Set up a domain for a static site
- Intro to GitHub Pages, Netlify, and Vercel
- Deploying a portfolio site or landing page
- Custom domain linking
- Hands-on: Launch your personal site

### Buy a domain

1.  Choose a domain name that reflects your brand or project.
2.  Use a domain registrar (e.g., GoDaddy, Namecheap) to check availability.
3.  Follow the registrar's process to purchase the domain.
4.  Configure DNS settings to point to your hosting provider.

#### Tips to Buy Domain

- Keep it short and memorable.
- Avoid numbers and hyphens.
- Choose the right domain extension (.com, .net, .org, etc.).
- Check social media availability for your domain name.
- Consider domain privacy protection to keep your information safe.

#### Set Up Hosting

1.  Choose a hosting provider (e.g., Netlify, Vercel, GitHub Pages).
2.  Create an account and follow the provider's setup instructions.
3.  Connect your domain to the hosting provider by updating DNS records.
4.  Deploy your static site by pushing your code to the hosting platform.

#### Tips for Hosting

- Choose a provider that fits your needs (e.g., bandwidth, storage).
- Take advantage of free tiers for personal projects.
- Use continuous deployment for easier updates.
- Monitor your site's performance and uptime.

#### Troubleshooting Tips

- Check DNS settings if your site is not reachable.
- Review hosting provider documentation for common issues.
- Use browser developer tools to diagnose front-end problems.
- Reach out to support communities for help.

#### Deploy static site to firebase

1.  Install Firebase CLI: `npm install -g firebase-tools`
2.  Login to Firebase: `firebase login`
3.  Initialize Firebase in your project: `firebase init`
4.  Choose "Hosting" and follow the prompts.
5.  Deploy your site: `firebase deploy`

#### How to connect custom domain to Hosting using firebase hosting

1.  Go to the Firebase console.
2.  Select your project.
3.  Click on "Hosting" in the left sidebar.
4.  Click on "Add custom domain."
5.  Follow the prompts to verify your domain ownership.
6.  Update your DNS records as instructed.
7.  Wait for the changes to propagate (may take up to 48 hours).
8.  Your custom domain should now point to your Firebase hosting.

#### Additional Resources

- [Firebase Hosting Documentation](https://firebase.google.com/docs/hosting)
- [Custom Domain Setup Guide](https://firebase.google.com/docs/hosting/custom-domain)
- [Firebase CLI Documentation](https://firebase.google.com/docs/cli)
