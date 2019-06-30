# This file is exec'd from settings.py, so it has access to and can
# modify all the variables in settings.py.

DEBUG = bool(os.getenv("DJANGO_DEBUG_STATE")) or False

if not DEBUG:
    SUB_SITE_URL = os.getenv("DJANGO_SUB_SITE_URL") or ""
    SITE_TYPE = "http"
    SITE_BASE = os.getenv("DJANGO_SITE_BASE") or "example_url.com"
      
    CORS_REPLACE_HTTPS_REFERER = True
    CSRF_TRUSTED_ORIGINS  = [SITE_BASE]
    CORS_ORIGIN_WHITELIST = (
        SITE_TYPE + "://" + SITE_BASE,
    )
    
    STATIC_URL = SUB_SITE_URL + '/static/'
    MEDIA_URL = STATIC_URL + "/media/"
else:
    SUB_SITE_URL = os.getenv("DJANGO_SUB_SITE_URL") or ''
    SITE_TYPE = "http"
    SITE_BASE = os.getenv("DJANGO_SITE_BASE") or "localhost"
    SITE_PORT = str(os.getenv("DJANGO_SITE_PORT") or "8021")
    CORS_REPLACE_HTTPS_REFERER = True
    CSRF_TRUSTED_ORIGINS  = [SITE_BASE]
    CORS_ORIGIN_WHITELIST = (
        SITE_TYPE + "://" + SITE_BASE,
    )
    STATIC_URL = SUB_SITE_URL + '/static/'
    MEDIA_URL = SUB_SITE_URL + "/media/"

STATIC_ROOT = os.getenv("DJANGO_STATIC_ROOT") or os.path.join(PROJECT_ROOT, STATIC_URL.strip("/"))

SITE_URL = SITE_TYPE + "://" + SITE_BASE + SUB_SITE_URL
ALLOWED_HOSTS = ["localhost", "127.0.0.1", "::1", SITE_BASE]
 
# Make these unique, and don't share it with anybody.
SECRET_KEY = "9i6=z8)50z*#9d_gvnlq-_zt#x!!vp$o4b5_+j4l&ki(8#@qi7"
NEVERCACHE_KEY = "wd5q*aw48y%81d(9hgv+to0h_9dff!8wu9#f)iqt)m@@l1)jw8"

DATABASES = {
    "default": {
        # Ends with "postgresql_psycopg2", "mysql", "sqlite3" or "oracle".
        "ENGINE": "django.db.backends.sqlite3",
        # DB name or path to database file if using sqlite3.
        "NAME": "dev.db",
        # Not used with sqlite3.
        "USER": "",
        # Not used with sqlite3.
        "PASSWORD": "",
        # Set to empty string for localhost. Not used with sqlite3.
        "HOST": "",
        # Set to empty string for default. Not used with sqlite3.
        "PORT": "",
    }
}

BLOG_USE_FEATURED_IMAGE = True

#mezzanine
RICHTEXT_ALLOWED_STYLES =('border', 'display', 'float', 'list-style-type', 'margin', 'margin-bottom', 'margin-left', 'margin-right', 'margin-top', 'padding-left', 'text-align', 'text-decoration', 'vertical-align', 'clear')
RICHTEXT_FILTERS = ('mezzanine.utils.html.thumbnails', 'additionals.richtext_filters.richtext_path_replace')

INSTALLED_APPS += [
    "foo"    
]

###################
# DEPLOY SETTINGS #
###################

# These settings are used by the default fabfile.py provided.
# Check fabfile.py for defaults.

# FABRIC = {
#     "DEPLOY_TOOL": "rsync",  # Deploy with "git", "hg", or "rsync"
#     "SSH_USER": "",  # VPS SSH username
#     "HOSTS": [""],  # The IP address of your VPS
#     "DOMAINS": [""],  # Will be used as ALLOWED_HOSTS in production
#     "REQUIREMENTS_PATH": "requirements.txt",  # Project's pip requirements
#     "LOCALE": "en_US.UTF-8",  # Should end with ".UTF-8"
#     "DB_PASS": "",  # Live database password
#     "ADMIN_PASS": "",  # Live admin user password
#     "SECRET_KEY": SECRET_KEY,
#     "NEVERCACHE_KEY": NEVERCACHE_KEY,
# } 
