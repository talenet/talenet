<template>
  <div class="row">
    <div class="t-center-col">
      <t-introduction-box messagesKey="alpha.contact">
        {{$t('alpha.contact.text')}}

        <ul>
          <li>
            <a href="https://github.com/talenet/talenet/issues" target="_blank">
              {{$t('alpha.contact.issueTracker')}}
            </a>
          </li>
          <li>
            {{$t('alpha.contact.contactEmail')}}:
            <a href="mailto:contact@t4l3.net" target="_blank">
              contact@t4l3.net
            </a>
          </li>
          <li>
            {{$t('alpha.contact.newsletterEmail')}}:
            <a href="mailto:newsletter-subscribe@t4l3.net" target="_blank">
              newsletter-subscribe@t4l3.net
            </a>
          </li>
        </ul>
      </t-introduction-box>
    </div>
  </div>
</template>

<script>
  export default {}
</script>
