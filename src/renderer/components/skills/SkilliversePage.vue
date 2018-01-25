<template>
  <div class="t-skilliverse">
    <t-skill-graph :skills="skills" :similarities="similarities"></t-skill-graph>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': ['skill/subscribeAll', 'skill/subscribeSimilarities']
      })
    ],

    computed: {
      ...mapGetters({
        'skills': 'skill/all',
        'similarities': 'skill/similarities'
      })
    },

    methods: {
      /*
      voteSimilar () {
        const selectedSkillKeys = this.selectedSkillKeys
        if (selectedSkillKeys.length !== 2) {
          alert('Invalid selection')
          return
        }

        const data = {
          skillKey1: selectedSkillKeys[0],
          skillKey2: selectedSkillKeys[1]
        }

        if (!data.skillKey1 || !data.skillKey2) {
          alert('Invalid skill keys')
          return
        }

        this.$refs.voteSimilar.dispatch('skill/voteAsSimilar', data)
          .then(() => {
            this.selectedNodes = {}
          })
          .catch(err => {
            if (err) {
              console.error(err)
            }
          })
      }
    */
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
