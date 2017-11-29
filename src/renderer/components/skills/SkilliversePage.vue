<template>
  <div>
    <b-card>
      <t-create-skill-form></t-create-skill-form>
    </b-card>

    <b-card>
      <b-form-input v-model="searchTerm" @input="search()"></b-form-input>
      <div>
        <b-badge variant="primary" v-for="skill in matchingSkills" :key="skill.key()">{{skill.name()}} [+]</b-badge>
      </div>
    </b-card>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
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
      }),

      matchingSkills () {
        return this.matchingSkillKeys.map((key) => this.skill(key))
      }
    },
    methods: {
      search () {
        if (this.runningSearch && this.runningSearch.isPending()) {
          this.runningSearch.cancel()
        }
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
      }
    }
  }
</script>
