---
layout: default
permalink: /cv/
title: cv
nav: true
nav_order: 4
cv_pdf: /assets/pdf/Xiyun%20CV.pdf # you can also use external links here
cv_format: rendercv # options: rendercv, jsonresume
description: Ph.D. candidate in Mechanical Engineering working at the intersection of AR/XR, machine learning, computer vision, and human-centered authoring tools.
toc:
  sidebar: left
---

<link rel="stylesheet" href="{{ '/assets/css/al-folio-cv.css' | relative_url }}">

<style type="text/css">
  .cv .list-group-item > .row {
    align-items: flex-start;
  }

  .cv .list-group-item > .row > [class*="col-xs-2"].text-center {
    order: 2;
    flex: 0 0 9rem;
    max-width: 9rem;
    margin-left: 0 !important;
    padding-left: 0;
    padding-right: 0;
    text-align: right !important;
  }

  .cv .list-group-item > .row > [class*="col-xs-2"].text-center.date-column {
    margin-left: 15px !important;
  }

  .cv .list-group-item > .row > [class*="col-xs-10"] {
    order: 1;
    flex: 1 1 auto;
    max-width: calc(100% - 10rem);
  }

  .cv .list-group-item > .row > [class*="col-xs-10"] .ml-1,
  .cv .list-group-item > .row > [class*="col-xs-10"] .ml-md-4 {
    margin-left: 0 !important;
  }

  .cv .list-group-item > .row > [class*="col-xs-2"].text-center .table-cv {
    width: 100%;
    margin-left: auto;
    margin-right: 0;
  }

  .cv .list-group-item > .row > [class*="col-xs-2"].text-center .badge {
    display: inline-block;
    min-width: 7.25rem !important;
    text-align: center;
  }

  .cv .list-group-item > .row > [class*="col-xs-2"].text-center p.location {
    margin-bottom: 0;
    text-align: right;
    white-space: normal;
    line-height: 1.25;
  }

  @media (max-width: 575.98px) {
    .cv .list-group-item > .row > [class*="col-xs-2"].text-center {
      flex-basis: 6.75rem;
      max-width: 6.75rem;
      margin-left: 0 !important;
      padding-left: 0;
    }

    .cv .list-group-item > .row > [class*="col-xs-10"] {
      max-width: calc(100% - 7.75rem);
    }

    .cv .list-group-item > .row > [class*="col-xs-2"].text-center .badge {
      min-width: 5.75rem !important;
    }
  }
</style>

{% assign cv_feature_enabled = site.al_folio.features.cv.enabled | default: true %}

{% if site.plugins contains 'al_folio_cv' and cv_feature_enabled %}
{% al_folio_cv_render %}
{% else %}

  <div class="post">
    <header class="post-header">
      <h1 class="post-title">{{ page.title }}</h1>
      <p class="post-description">CV rendering is unavailable.</p>
    </header>
    <article>
      <p>Enable the <code>al_folio_cv</code> plugin and set <code>al_folio.features.cv.enabled: true</code> to render this page.</p>
    </article>
  </div>
{% endif %}
