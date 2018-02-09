<template>
  <div class="t-skilliverse">
    <t-skill-graph
      :skills="skills"
      :similarities="similarities"
      :ownIdentity="ownIdentity">
    </t-skill-graph>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': [
          'skill/subscribeAll',
          'skill/subscribeSimilarities',
          'identity/own'
        ]
      })
    ],

    computed: {
      ...mapGetters({
        'skills': 'skill/all',
        'similarities': 'skill/similarities',
        'ownIdentity': 'identity/own'
      })
    }
  }
</script>

<style lang="scss">
  @import "../../variables";

  .t-skilliverse {
    position: absolute;

    left: 0;
    right: 0;
    top: $skilliverse-top;
    bottom: $skilliverse-bottom;

    background-color: $skilliverse-bg;
  }
</style>
