<template>
  <div class="t-skilliverse">
    <t-introduction-box
      messages-key="skill.skilliverse.introduction"
      type="overlay"
      @close="$refs.skillGraph.resumeSimulation()">
    </t-introduction-box>

    <t-skill-graph
      ref="skillGraph"
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
          'identity/subscribeOwnIdentityKey'
        ],
        'ownIdentityKey': 'identity/subscribe'
      })
    ],

    computed: {
      ...mapGetters({
        'skills': 'skill/all',
        'similarities': 'skill/similarities',
        'ownIdentityKey': 'identity/ownIdentityKey',
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

    overflow: hidden; // prevent scrollbars

    background-color: $skilliverse-bg;
  }
</style>
