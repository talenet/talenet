<template>
  <div class="t-pub-list">
    <div class="t-pub-list-heading">{{$t('pub.list.heading')}}</div>

    <t-text-box v-if="pubs && pubs.length">
      <div class="t-pub-list-pub" v-for="pub in pubs" :key="pub.key()">
        <div>
          {{pub.host()}}:{{pub.port()}}
          <small class="text-muted">({{pub.timestamp() | tFormatTimestamp}})</small>
        </div>
        <small class="text-muted">{{pub.key()}}</small>
      </div>
    </t-text-box>
    <div v-else class="t-pub-list-none text-muted">{{$t('pub.list.none')}}</div>
  </div>
</template>

<script>
  import SubscriptionMixin from '../../mixins/Subscription'

  export default {
    mixins: [
      SubscriptionMixin({
        '!': 'ssb/subscribePubs'
      })
    ],

    computed: {
      pubs () {
        const pubs = Object.values(this.$store.getters['ssb/pubs'])
        pubs.sort((pub1, pub2) => {
          if (pub1 === pub2) {
            return 0
          }
          if (!pub1) {
            return -1
          }

          const timestamp1 = pub1.timestamp()
          const timestamp2 = pub2.timestamp()
          if (!timestamp1) {
            return -1
          }
          if (!timestamp2) {
            return 1
          }
          return timestamp2 - timestamp1 // new pub connections at the top
        })
        return pubs
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "../../variables";

  .t-pub-list {
    margin: {
      top: $pub-list-margin-y;
      bottom: $pub-list-margin-y;
    }
  }

  .t-pub-list-pub {
    margin-bottom: $pub-list-margin-y;

    &:last-child {
      margin-bottom: 0;
    }
  }

  .t-pub-list-heading,
  .t-pub-list-none {
    margin: {
      left: $pub-list-margin-x;
      right: $pub-list-margin-x;
    }
  }

  .t-pub-list-heading {
    margin-bottom: $pub-list-margin-y;
  }
</style>
