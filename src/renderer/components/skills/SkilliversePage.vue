<template>
  <div class="t-skilliverse">
    <b-form-input v-model="term"></b-form-input>

    <t-action-button
      v-if="selectedSkillKeys.length === 2"
      ref="voteSimilar"
      variant="primary"
      @click="voteSimilar()">
      Vote as similar
    </t-action-button>

    <d3-network
      :selection="{ nodes: selectedNodes, links: {} }"
      :net-nodes="nodes"
      :net-links="links"
      :options="options"
      @node-click="nodeClick">
    </d3-network>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'
  import Vue from 'vue'
  import { mapGetters } from 'vuex'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': ['skill/subscribeAll', 'skill/subscribeSimilarities']
      })
    ],

    data () {
      return {
        term: '',
        selectedNodes: {},

        options: {
          nodeSize: 30,
          nodeLabels: true,
          forces: {
            X: 0.2,
            Y: 0.2,
            Link: true
          }
        }
      }
    },

    computed: {
      ...mapGetters({
        'skills': 'skill/all',
        'similarities': 'skill/similarities'
      }),

      nodes () {
        const term = this.term.trim().toLowerCase()
        const nodes = []
        for (const skill of this.skills) {
          if (skill.name().trim().toLowerCase().includes(term)) {
            nodes.push({
              id: skill.key(),
              name: skill.name()
            })
          }
        }
        return nodes
      },

      links () {
        const links = []
        const similarities = this.similarities

        for (const skillKey1 of Object.keys(similarities)) {
          const skillSimilarities = similarities[skillKey1]
          for (const skillKey2 of Object.keys(skillSimilarities)) {
            const votes = skillSimilarities[skillKey2] || 0
            if (votes > 0) {
              links.push({
                tid: skillKey1,
                sid: skillKey2
              })
            }
          }
        }

        return links
      },

      selectedSkillKeys () {
        return Object.keys(this.selectedNodes)
      }
    },

    methods: {
      nodeClick (event, node) {
        const skillKey = node.id
        const isSelected = this.selectedNodes[skillKey] !== undefined

        if (isSelected) {
          Vue.delete(this.selectedNodes, skillKey)
        } else {
          Vue.set(this.selectedNodes, skillKey, node)
        }
      },

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
    }
  }
</script>

<style lang="scss">
  @import "../../variables";

  .t-skilliverse {
    position: absolute;
    left: 0;
    right: 0;
    top: 10%;
    bottom: 10%;

    .net {
      height: 90%;

      text {
        pointer-events: none;
        user-select: none;
      }

      .node {
        cursor: pointer;
        fill: $tale-dark-grey;
        stroke: $tale-dark-blue;
        stroke-width: 1px;

        &.selected {
          fill: $tale-grey;
          stroke: $tale-yellow;
        }
      }

      .node-label {
        font-size: 1rem;
        fill: $tale-dark-blue;
      }

      .link {
        stroke: $tale-dark-blue;
      }
    }
  }
</style>
