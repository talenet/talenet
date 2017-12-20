<template>
  <div class="row">
    <t-text-box class="t-center-col">
      {{$t('congress.text')}}

      <ul>
        <li>
          <a href="https://github.com/talenet/talenet/issues" target="_blank">
            {{$t('congress.issueTracker')}}
          </a>
        </li>
        <li>
          {{$t('congress.contactEmail')}}:
          <a href="mailto:contact@t4l3.net" target="_blank">
            contact@t4l3.net
          </a>
        </li>
        <li>
          {{$t('congress.newsletterEmail')}}:
          <a href="mailto:newsletter-subscribe@t4l3.net" target="_blank">
            newsletter-subscribe@t4l3.net
          </a>
        </li>
      </ul>
    </t-text-box>
  </div>
</template>

<script>
  export default {}
</script>
