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
          <a href="mailto:" target="_blank">
            foo@bar.fail
          </a>
        </li>
      </ul>
    </t-text-box>
  </div>
</template>

<script>
  export default {}
</script>
