# Deployment Guide - Rum River Website

## Quick Deploy
```bash
git add .
git commit -m "Your changes"
git push origin master
```
Netlify will automatically deploy within 1-2 minutes.

## Verify Deployment
1. Check GitHub Actions (if configured): https://github.com/ryanpedersonphotography/rumrivermn-website/actions
2. Check Netlify Dashboard: https://app.netlify.com/sites/rumriverold/deploys
3. Visit live site: https://rumrivermn.com

## Deployment Pipeline

```
Local Changes → Git Push → GitHub → Netlify Webhook → Auto Deploy → Live Site
```

## Rollback if Needed
```bash
# Via Netlify Dashboard
netlify open:admin
# Go to Deploys tab → Click on previous successful deploy → "Publish deploy"

# Via Git
git revert HEAD
git push origin master
```

## Environment Details
- **Production URL**: https://rumrivermn.com
- **Netlify URL**: https://rumriverold.netlify.app
- **Deploy Branch**: master
- **Auto Deploy**: Enabled
- **Deploy Notifications**: Check Netlify dashboard

## Testing Before Deploy
```bash
# Local server
python3 -m http.server 8000
# Visit http://localhost:8000

# Or use Netlify Dev
netlify dev
# Visit http://localhost:8888
```

## Common Issues

### Deploy Not Triggering
- Ensure you're pushing to `master` branch
- Check GitHub webhook is active
- Verify Netlify build is not locked

### Images Not Loading
- Check file paths are relative (not absolute)
- Verify images exist in `/files/` directory
- Ensure no lazy loading JavaScript dependencies

### Forms Not Working
- Netlify Forms require `data-netlify="true"` attribute
- Form action should point to thank you page
- Check Netlify Forms dashboard for submissions

## Last Successful Deploy
- Date: November 11, 2024
- Commit: Added README documentation
- Status: ✅ Deployed successfully