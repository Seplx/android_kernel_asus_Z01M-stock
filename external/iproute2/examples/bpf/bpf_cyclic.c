#include "../../include/bpf_api.h"

/* Cyclic dependency example to test the kernel's runtime upper
 * bound on loops. Also demonstrates on how to use direct-actions,
 * loaded as: tc filter add [...] bpf da obj [...]
 */
#define JMP_MAP_ID	0xabccba

BPF_PROG_ARRAY(jmp_tc, JMP_MAP_ID, PIN_OBJECT_NS, 1);

__section_tail(JMP_MAP_ID, 0)
int cls_loop(struct __sk_buff *skb)
{
	char fmt[] = "cb: %u\n";

	trace_printk(fmt, sizeof(fmt), skb->cb[0]++);
	tail_call(skb, &jmp_tc, 0);

	skb->tc_classid = TC_H_MAKE(1, 42);
	return TC_ACT_OK;
}

__section_cls_entry
int cls_entry(struct __sk_buff *skb)
{
	tail_call(skb, &jmp_tc, 0);
	return TC_ACT_SHOT;
}

BPF_LICENSE("GPL");
