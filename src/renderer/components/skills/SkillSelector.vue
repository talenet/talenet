<template>
  <b-card>
    <b-form-input v-model="searchTerm" @input="search()"></b-form-input>
    <div>
      <b-badge
        variant="primary"
        v-for="skillKey in matchingSkillKeys"
        :key="skillKey"
        @click="selectSkill(skillKey)"
      >
        <span v-if="skill(skillKey)">{{skill(skillKey).name()}} [+]</span>
        <t-loading-animation v-else></t-loading-animation>
      </b-badge>
    </div>
  </b-card>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin
    ],

    data () {
      return {
        searchTerm: '',
        matchingSkillKeys: [],
        runningSearch: null
      }
    },
    computed: {
      ...mapGetters({
        skill: 'skill/get'
      })
    },
    methods: {
      subscriptions () {
        return {
          'matchingSkillKeys': 'skill/subscribe'
        }
      },

      reset () {
        this.cancelSearch()
        this.searchTerm = ''
        this.matchingSkillKeys = []
      },

      cancelSearch () {
        if (this.runningSearch && this.runningSearch.isPending()) {
          this.runningSearch.cancel()
        }
        this.runningSearch = null
      },

      search () {
        this.cancelSearch()
        const promise = this.$store.dispatch('skill/search', this.searchTerm)
        this.runningSearch = promise
          .then((skillKeys) => {
            this.matchingSkillKeys = skillKeys
          })
          .catch((err) => {
            if (err) {
              console.error(err)
            }
          })
          .finally(() => {
            if (promise.isCancelled()) {
              this.runningSearch = null
            }
          })
      },

      selectSkill (key) {
        this.reset()
        this.$emit('select', key)
      }
    }
  }
</script>
