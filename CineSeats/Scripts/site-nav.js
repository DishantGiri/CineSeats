// Active nav link highlight
(function () {
    var path = window.location.pathname.toLowerCase();
    document.querySelectorAll('.cs-nav-link, .cs-dropdown-item').forEach(function (el) {
        var href = (el.getAttribute('href') || '').toLowerCase();
        if (href && href !== '/' && path.indexOf(href.replace(/^.*\//, '')) > -1) {
            el.classList.add('active');
        } else if ((path === '/' || path.endsWith('default.aspx')) && href === '/') {
            el.classList.add('active');
        }
    });
})();
