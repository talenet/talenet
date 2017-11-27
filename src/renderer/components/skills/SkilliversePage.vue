<template>
  <div>
    <b-card>
      <t-create-skill-form></t-create-skill-form>
    </b-card>

    <b-card>
      <b-form-input v-model="searchTerm" @input="search()"></b-form-input>
      <ul>
        <li v-for="skill in matchingSkills" :key="skill.key()">{{skill.name()}}</li>
      </ul>
    </b-card>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    data () {
      return {
        searchTerm: '',
        matchingSkillKeys: []
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
        this.$store.dispatch('skill/search', this.searchTerm)
          .then((skillKeys) => {
            this.matchingSkillKeys = skillKeys
          })
          .catch((err) => {
            if (err) {
              console.error(err)
            }
          })
      }
    }
  }
</script>
