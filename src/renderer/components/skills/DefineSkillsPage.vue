<template>
  <div>
    <h1>TODO: Create skill example</h1>

    <b-card>
      <t-create-skill-form></t-create-skill-form>
    </b-card>

    <h1>TODO: Select skill example</h1>

    <t-skill-selector @select="selected = $event"></t-skill-selector>

    <b-badge variant="success" v-if="selected">{{skill(selected).name()}}</b-badge>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    data () {
      return {
        selected: null
      }
    },

    computed: {
      ...mapGetters({
        skill: 'skill/get'
      })
    }
  }
</script>
