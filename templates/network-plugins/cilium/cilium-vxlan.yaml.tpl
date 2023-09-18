---
# Source: cilium/templates/cilium-agent/serviceaccount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: "cilium"
  namespace: kube-system
---
# Source: cilium/templates/cilium-operator/serviceaccount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: "cilium-operator"
  namespace: kube-system
---
# Source: cilium/templates/cilium-ca-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: cilium-ca
  namespace: kube-system
data:
  ca.crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURFekNDQWZ1Z0F3SUJBZ0lRZnNrekV3STZ4R2VzeVU5eUQ5S04yakFOQmdrcWhraUc5dzBCQVFzRkFEQVUKTVJJd0VBWURWUVFERXdsRGFXeHBkVzBnUTBFd0hoY05Nak13T1RFNE1UVXhNVEUyV2hjTk1qWXdPVEUzTVRVeApNVEUyV2pBVU1SSXdFQVlEVlFRREV3bERhV3hwZFcwZ1EwRXdnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCCkR3QXdnZ0VLQW9JQkFRRFR4RHlnaTZ3OStxYjFTaElOWGdhQ09HeTBVWlNQcElMcldxWlUrVmtJY3RNejJlREMKbG1JQk9zb0x0K2UvQTNHeEVleVBCNUZVeEJCbnVON0x2Q245Sjg2aFNTVXZ3c0U3aWI5aXo5SnpiTE9UcEUyQQpJelM3MUdJbFVTS3pmbmE1VDU3dHhMTDg1YStQOHZ6bVZmc0NFSkFWM2IxVXg4Z2ZpYlRDYVAxSWJETmRIZThMCjdxOVFGWUdoM0hGZ1ZqVnd6VGMwUGdMcmhOQkdMN2FKUHRveW5DLzhhV0VSSExVbGE4RkxoQ0preXp4cFJZa0kKdnFsekQzSmFrQUdzbndkZllEQVVWNUROT1hVNFlqS0lXV0JiQmd4NUdKMTcxVjdCMzJJNGZuZkRyUXR4NGlTOQpYNjVzMzcrdlZMYmVtSTNIaDI2RUF1MVBndTk2aXN2WlFQMjlBZ01CQUFHallUQmZNQTRHQTFVZER3RUIvd1FFCkF3SUNwREFkQmdOVkhTVUVGakFVQmdnckJnRUZCUWNEQVFZSUt3WUJCUVVIQXdJd0R3WURWUjBUQVFIL0JBVXcKQXdFQi96QWRCZ05WSFE0RUZnUVVSS1Q4REtLL00zNEk0T2JSTlVIWHhJNUlFdVV3RFFZSktvWklodmNOQVFFTApCUUFEZ2dFQkFCTVZGaklEVVlNMUlmU1JLbFFBTXlMcERYOGs3TVFNMUUvWG00SEpWZVBEVXFHN2cya0ZpandECnFMeXFPQWJWbGhUeitwclROd0hGOGNxRFBqdE4vM2luZHFIdzRTS1gvWFJTV3R6YmFUQ2xNd1htdERvWVZ4RE0KcXVQZkdJeFFEYVRMS204R0dYeVoyNWFDRkphUlRkUVM4TkM5YWFqaExselhqZGVOVS9PdDZsaXFDTDNDTHhYSQo0Z0wyYldkb01NdTBuK2pVZFZ1TEFTR0JWVUl4dGxoeHRqMGdnMDFHbTZ0dVRkZ2ZNQU5ZcXlWMzR0bDdSVElOCitOREVqdENWd3RyS1l1TnlseUtBS2tYYzJ1K0ZQZ1FEOUlVeEk0QjhPQTh3NlNuU0NRUVg1dE84eDF3NEVOZ1gKamxrcmU5a1JTclY1ajZJWTBmb0IvOTd6TGtUdkptQT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=
  ca.key: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcFFJQkFBS0NBUUVBMDhROG9JdXNQZnFtOVVvU0RWNEdnamhzdEZHVWo2U0M2MXFtVlBsWkNITFRNOW5nCndwWmlBVHJLQzdmbnZ3TnhzUkhzandlUlZNUVFaN2pleTd3cC9TZk9vVWtsTDhMQk80bS9Zcy9TYzJ5ems2Uk4KZ0NNMHU5UmlKVkVpczM1MnVVK2U3Y1N5L09XdmovTDg1bFg3QWhDUUZkMjlWTWZJSDRtMHdtajlTR3d6WFIzdgpDKzZ2VUJXQm9keHhZRlkxY00wM05ENEM2NFRRUmkrMmlUN2FNcHd2L0dsaEVSeTFKV3ZCUzRRaVpNczhhVVdKCkNMNnBjdzl5V3BBQnJKOEhYMkF3RkZlUXpUbDFPR0l5aUZsZ1d3WU1lUmlkZTlWZXdkOWlPSDUzdzYwTGNlSWsKdlYrdWJOKy9yMVMyM3BpTng0ZHVoQUx0VDRMdmVvckwyVUQ5dlFJREFRQUJBb0lCQVFDVTZ6QVRXb1dTeEZ4NgpyRThMbFc2UVRxdXJGcCtaY0FBZEVBOWVQRWN2R01pTGN4R0s1WVFnQno2a2hQeDBxREJnYkJGbDk5VnN2Y0FuCm9Lc1VyTXIrV3VzRkl0SUN4enRwNmhGcnBHZ0RnWks3SmRUV1ltdW9Gcys2SEZlQjBGSWZPTzJ6bVJxaG04Z2QKTzZ3N01vV2t5dzc0UVludVA5dnN5Y01TNEJBVng3RWdoVlBUMlRleTRaWXI3QVV2TTdSVmZWQkVQSml3aFVLZwpGK2ZjSHNTb0dTS0RyMk5nR3Y3TTdMVkpTaUhGbE00YVI3cEg2bkhEUUYrYjZFUit2bmU0R0FJeUhFa04vOW8yCmVJb2dnajZzR0RIZHhrMENxTzNxdmxYRUQ3RFlUUWl0NkpsV1BhcHB5NEpXUlBCK1pSOHdPRVNhTWo3aGZKQkIKZzk1N1JRVGxBb0dCQVBoNStyZTVuVURTRVE1TW8vOEhwSHlGRTlwVDRhRS9rei9SVkRuL0M0cmJoUGRQV0swQgpzVGd1RXRtaW1YbzR0TkczU0hMR0NNcUUxOEdSUUIxNFJETTV6R0hOWUdpdVJ1S0JkQmVpYkpobE9rb2RRVjNSCkFnQmdDbW5zcHNtR2ZXUFZkOVp1d2Vtc0dIaXRFL0tqdUl6NEk5anFGRnhMSlM0NjhKWjNvTUdqQW9HQkFOb3QKdFFETkU3UmhqeHRnYzNodTVhT21saWNnUHhIWmpFNS9jK3RNOTZSM2hweTNweStMVm45V3FHTFl3R0V5R2FFUQpkczlPZ3BwRk96bGhkNmt5WGMydS9GeEp6b290TjliVWlGUU00TWdyV1lLWFFNb1hSclFaUmwzVUlXQWc4bGowCjQ1LyszZ1dYTTZ2WnF6STBzMGRvbWlIMGhrZ3B0ckZiSVg1WTV2a2ZBb0dCQUtlYUw4R3AxQ2FiQzZJbmxCODgKV25rYmtxNmNFZitnVUlTbGdEaTJqbVNWZWZVUGNuTVFSeWZyL0E4TkhKVlNsclUyK2dsaEJ5RUR4anpzNnVCMQo5UnJRaThvVXJFa3Y5T1JvQ1pTL25KeVcrMkJ1cDE3TzBwaktMM3dQZ3RsQWZHZlEzOHFtWHVwdGlQd3RVdDFDCkRnUVloS1dXRHpIS0JrUk93V1hkUDNRZEFvR0FWbExEVE4vWExnVnpvN2RUdUpEWUZ4bndTdWE5VFlpdnROZEUKdkJLbDROTFIxZXZzSUNtWFBhYkIxT3BCbzdNNDVMc281dmovUDU2b3dobElTUTkrZ2NUOFlGOXJjc3hWVFpDbApwK3U0ZkRwNm5lck9YYWM3K0VJUHowd0JNSkdZa1kzRENpakRHNThwZUpNVTR6WnF3SlFvZDhyUjNuZHlxMVdOCk9QcGYySzBDZ1lFQTBXVEZuaFhhcDJvUUFDTVlIUHZSS0o0M2RjZ0Q5aVJ0ZFJtTGFpdG9PSGJIeUxMcXgrUXMKa1VLTXBjM2ZiMVRrbXNRTUpIL3poY2diVzVTclc3RWpyV1R6WEhzaUlLK0hMenJOTjNHVGM4Zml4Nk9hR3VzZApBNkRBTEdtYjZtd2tEZTdlNHhpbjZ6YXRJWWwySW1KZ1pycXBMUnF2Yy9SdlZzS2IzWmM3V1ZJPQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo=
---
# Source: cilium/templates/hubble/tls-helm/server-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: hubble-server-certs
  namespace: kube-system
type: kubernetes.io/tls
data:
  ca.crt:  LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURFekNDQWZ1Z0F3SUJBZ0lRZnNrekV3STZ4R2VzeVU5eUQ5S04yakFOQmdrcWhraUc5dzBCQVFzRkFEQVUKTVJJd0VBWURWUVFERXdsRGFXeHBkVzBnUTBFd0hoY05Nak13T1RFNE1UVXhNVEUyV2hjTk1qWXdPVEUzTVRVeApNVEUyV2pBVU1SSXdFQVlEVlFRREV3bERhV3hwZFcwZ1EwRXdnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCCkR3QXdnZ0VLQW9JQkFRRFR4RHlnaTZ3OStxYjFTaElOWGdhQ09HeTBVWlNQcElMcldxWlUrVmtJY3RNejJlREMKbG1JQk9zb0x0K2UvQTNHeEVleVBCNUZVeEJCbnVON0x2Q245Sjg2aFNTVXZ3c0U3aWI5aXo5SnpiTE9UcEUyQQpJelM3MUdJbFVTS3pmbmE1VDU3dHhMTDg1YStQOHZ6bVZmc0NFSkFWM2IxVXg4Z2ZpYlRDYVAxSWJETmRIZThMCjdxOVFGWUdoM0hGZ1ZqVnd6VGMwUGdMcmhOQkdMN2FKUHRveW5DLzhhV0VSSExVbGE4RkxoQ0preXp4cFJZa0kKdnFsekQzSmFrQUdzbndkZllEQVVWNUROT1hVNFlqS0lXV0JiQmd4NUdKMTcxVjdCMzJJNGZuZkRyUXR4NGlTOQpYNjVzMzcrdlZMYmVtSTNIaDI2RUF1MVBndTk2aXN2WlFQMjlBZ01CQUFHallUQmZNQTRHQTFVZER3RUIvd1FFCkF3SUNwREFkQmdOVkhTVUVGakFVQmdnckJnRUZCUWNEQVFZSUt3WUJCUVVIQXdJd0R3WURWUjBUQVFIL0JBVXcKQXdFQi96QWRCZ05WSFE0RUZnUVVSS1Q4REtLL00zNEk0T2JSTlVIWHhJNUlFdVV3RFFZSktvWklodmNOQVFFTApCUUFEZ2dFQkFCTVZGaklEVVlNMUlmU1JLbFFBTXlMcERYOGs3TVFNMUUvWG00SEpWZVBEVXFHN2cya0ZpandECnFMeXFPQWJWbGhUeitwclROd0hGOGNxRFBqdE4vM2luZHFIdzRTS1gvWFJTV3R6YmFUQ2xNd1htdERvWVZ4RE0KcXVQZkdJeFFEYVRMS204R0dYeVoyNWFDRkphUlRkUVM4TkM5YWFqaExselhqZGVOVS9PdDZsaXFDTDNDTHhYSQo0Z0wyYldkb01NdTBuK2pVZFZ1TEFTR0JWVUl4dGxoeHRqMGdnMDFHbTZ0dVRkZ2ZNQU5ZcXlWMzR0bDdSVElOCitOREVqdENWd3RyS1l1TnlseUtBS2tYYzJ1K0ZQZ1FEOUlVeEk0QjhPQTh3NlNuU0NRUVg1dE84eDF3NEVOZ1gKamxrcmU5a1JTclY1ajZJWTBmb0IvOTd6TGtUdkptQT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=
  tls.crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURWekNDQWorZ0F3SUJBZ0lSQVBNWmlrbmZrRWl1NUxxRzNIcC9tcFF3RFFZSktvWklodmNOQVFFTEJRQXcKRkRFU01CQUdBMVVFQXhNSlEybHNhWFZ0SUVOQk1CNFhEVEl6TURreE9ERTFNVEV4TjFvWERUSTJNRGt4TnpFMQpNVEV4TjFvd0tqRW9NQ1lHQTFVRUF3d2ZLaTVrWldaaGRXeDBMbWgxWW1Kc1pTMW5jbkJqTG1OcGJHbDFiUzVwCmJ6Q0NBU0l3RFFZSktvWklodmNOQVFFQkJRQURnZ0VQQURDQ0FRb0NnZ0VCQUwxZGVNV0N3QWxSVlJyazVSa0wKY0JmNGNCdVlvRlhSd3ljdWxQMGZGaFZ2eGd2djh1Qmp5OXM1dEIzNXBpVHJBd1VuaVNVQnYxRkRNZHNPTzdqWgpNb1lLN09Sc1plbi9lc1RieUh1RDBKNVl3YWQzRGlSQ3dYNlNGeVBKUDA0Sjh0TkxXMzBhdkpsZFl6ZjNUekplCkhycE1NUHNmRWVNb05yZ0Z0TGp0cWRoYmpaSUVqcGpPQmM0QVVEcXRGMlY3QTlId1g3dXh6azBaWGU0YkphTU8KUGI2ck0rL0ZIY1c0YU5EbURjSkY2em5jTTJOY1doNEFZQ3hvT2k4UDJqblNhUFpvdkxHbExPVExnK3NybUJsbApEODU0aWI2Z0VUcjEvZ3FLNGFoMDB1c2hXOUl0bStBTDhzWmo3QzRVUFFUWGhWdnB5czZkT0RRaUZ5VmZkRlI5CmhnTUNBd0VBQWFPQmpUQ0JpakFPQmdOVkhROEJBZjhFQkFNQ0JhQXdIUVlEVlIwbEJCWXdGQVlJS3dZQkJRVUgKQXdFR0NDc0dBUVVGQndNQ01Bd0dBMVVkRXdFQi93UUNNQUF3SHdZRFZSMGpCQmd3Rm9BVVJLVDhES0svTTM0SQo0T2JSTlVIWHhJNUlFdVV3S2dZRFZSMFJCQ013SVlJZktpNWtaV1poZFd4MExtaDFZbUpzWlMxbmNuQmpMbU5wCmJHbDFiUzVwYnpBTkJna3Foa2lHOXcwQkFRc0ZBQU9DQVFFQTBFKy82b254VkdOdkg3ZkdQWG03b2s2TThpcHAKVEd5cEpaeXdTM0dyM05YNWgrRUE3UVZ0d013WlVYSzRHOVczOXZmRE5SVWF1azZuclROei9DMEZMcGRVVVgrUQpZL3dDK3gvZXd3QTJPaTFna3lRTGtoTzlOYktISDJTckZZbWFtUk1FL2FaMnQ5ZnZKOFRNTEZLL2pzMjExMHpxCmUwRnFCZWp6VXVYaXZDSGhsTW9YRGI1dGJVY1BQK2JnZExrQk9xaXFQTjdIa1FZdTFpWFlqS1pXVnBtYkw4QnUKM0FKOVllQUJKbE9jT3NaQkwwTXRrZTlkL2xiQnV3ckdMOFZQblVPRFJoaVRIL2hrbEJ5cXRoOFQzNExQQ3hIWQpKNlZ0Z3J3RXM4c2lGZ0V3SGo0MUswbGFCM1pWaW12WEU0U2FBTElVcUllTlQwd0IrUU9iU0JMcENRPT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=
  tls.key: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBdlYxNHhZTEFDVkZWR3VUbEdRdHdGL2h3RzVpZ1ZkSERKeTZVL1I4V0ZXL0dDKy95CjRHUEwyem0wSGZtbUpPc0RCU2VKSlFHL1VVTXgydzQ3dU5reWhncnM1R3hsNmY5NnhOdkllNFBRbmxqQnAzY08KSkVMQmZwSVhJOGsvVGdueTAwdGJmUnE4bVYxak4vZFBNbDRldWt3dyt4OFI0eWcydUFXMHVPMnAyRnVOa2dTTwptTTRGemdCUU9xMFhaWHNEMGZCZnU3SE9UUmxkN2hzbG93NDl2cXN6NzhVZHhiaG8wT1lOd2tYck9kd3pZMXhhCkhnQmdMR2c2THcvYU9kSm85bWk4c2FVczVNdUQ2eXVZR1dVUHpuaUp2cUFST3ZYK0NvcmhxSFRTNnlGYjBpMmIKNEF2eXhtUHNMaFE5Qk5lRlcrbkt6cDA0TkNJWEpWOTBWSDJHQXdJREFRQUJBb0lCQUNZRnFhVkczcFpBWFcwNwovb0FyMnNNRllFVTZQUjllTWVnaEkwczd2YXhxT0FMWG1CWFVFKytkdzN1dFQ5M2p6a1J2cnNyZWNmSzRJaitRCnVROGhsVkp5eVNRSVcrSkRLUHgwQU9wRUNsUnhEOWszUDRDcVlyMnVTYlVteUc0Nzh5VFg0YlBaOVhwNTFOMDgKN0FyNStRT0JIdWlkVVhNaDlQSzRPcFJUTENKRHp1QXRoUE1UK2V2QTJHdlpnaTRWRFpOcWJZYys2RVo2Q2ZLOQozelllM0RiOWdPNDJibVlEU0xDZzFDNW5jRm5IdmllaTJSM2ZtZitocWlZaEJWaWIxSVowa2dDd2JIZ3hiWEZkCk9EMWh4akRoRVhaYmtPUlpaTTZPaHNWYTdWZHJDRWZ1TnFGY3IvTUd1d1l2RjVNbEh4K2RqblgrUEJaUTlpaXoKZTBGYXBBa0NnWUVBOUZuQWJ2R2hMRXZhcDhldzBySnc4eHBGSGRDekc1d1BQVXpVakYwbHVJM3FqaVMrUWxSOQpEODQ3TWpKbklQZS9DQUJ5YmphSjBGN3llQ2pFcGRnWE4zVmFRMExCYkRzSzcwR2JLMWdCZVVLRVFSd1ZUOFVPCnlrTUR4c094cHdvZHl0QjU3ZjRDaTRIWGNhdXNIbmU3UVo0Y1BOMnB4TGZCVXZXMXloNzJLMVVDZ1lFQXhtU2kKUXNhblg0M2g5QkwvdXd4Wml3U1hha1hNcHJnN1I4YkVrUkJBY281YVc2MXQvZ3NCWENucWpoSWE3YVE0Y2gxMgpMRDdDcG5aZWpabGRqMjkyYTJvS1NHSTNjVE1RTFBTSFJQK2FrdzA1TkRNV1gvVDVOc2ErTzN0aVMyaGp2RGNzCkhEeURSMmcyL3I0Tk1iK0F6SytSamtMaEZhcUswVVFkeFBaSTIvY0NnWUVBM2ZVbEt1SU1ZSnRxdkZ0VlVKN00Kb05jdEQxOURRd0lvaWF0ZnF6ejFoY1pMMk9DaGZza1diU1FOZTVSelAyd3NOODJJSkhzZ0Jvb293R052OWFIcgp2UEc1a3oxeFM2bjZUY2tQZFhqVXBkeDVIRmV4T0N1dE9xZFRKOXNkWmJsM3hJSkpMNWs3b0pQS0t6UWcvZkFPCnhoVWtXMW1TMitGN0Y2dWdmVUJRcHAwQ2dZRUFwRmZldGpRN21BTS9odUZxS0hkOWdaU0hIWWkraytrUGFsRDAKcWpwdE9MaEZqNllsOUlrSFVtS0NvN2ZKeU12OTJrSWZqMTFaLzIwVXZIV3NORktnSlRETlhkTEduS1l4SXh4WgpKY1liTk8rQ1VJUjFaMzNXS0JNUXFOTjN4SUd3Qk0wclpDU1lsMEYwTlNnWVkvcUFabzZWbytRdzhySzRsY3U0CllWMm5VMWNDZ1lBZUx3cGhYWnB1THFwQXQ1a0RMRkFVWlcxVEx1U1ZPS1VsbUh0VTIwTC9GbUJvazV5NU1lejcKKzl4Ti82MzNjSkswd3ZVajd3R2NZT3NldDJUK255VUtCdGpFSjJYRmtWMEl1Sm1FUnZwalZKN0tyREpkNEJoNApYRXYxTHJ5TmVIait1NDVuVThEZk9lRkR1Mmp5ZFJBKzhldmJXQmdBUDhpUGkzdytoMTl5NEE9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo=
---
# Source: cilium/templates/cilium-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: cilium-config
  namespace: kube-system
data:

  # Identity allocation mode selects how identities are shared between cilium
  # nodes by setting how they are stored. The options are "crd" or "kvstore".
  # - "crd" stores identities in kubernetes as CRDs (custom resource definition).
  #   These can be queried with:
  #     kubectl get ciliumid
  # - "kvstore" stores identities in an etcd kvstore, that is
  #   configured below. Cilium versions before 1.6 supported only the kvstore
  #   backend. Upgrades from these older cilium versions should continue using
  #   the kvstore by commenting out the identity-allocation-mode below, or
  #   setting it to "kvstore".
  identity-allocation-mode: crd
  identity-heartbeat-timeout: "30m0s"
  identity-gc-interval: "15m0s"
  cilium-endpoint-gc-interval: "5m0s"
  nodes-gc-interval: "5m0s"
  skip-cnp-status-startup-clean: "false"

  # If you want to run cilium in debug mode change this value to true
  debug: "false"
  # The agent can be put into the following three policy enforcement modes
  # default, always and never.
  # https://docs.cilium.io/en/latest/security/policy/intro/#policy-enforcement-modes
  enable-policy: "default"
  # Port to expose Envoy metrics (e.g. "9964"). Envoy metrics listener will be disabled if this
  # field is not set.
  proxy-prometheus-port: "9964"

  # Enable IPv4 addressing. If enabled, all endpoints are allocated an IPv4
  # address.
  enable-ipv4: "true"

  # Enable IPv6 addressing. If enabled, all endpoints are allocated an IPv6
  # address.
  enable-ipv6: "false"
  # Users who wish to specify their own custom CNI configuration file must set
  # custom-cni-conf to "true", otherwise Cilium may overwrite the configuration.
  custom-cni-conf: "false"
  enable-bpf-clock-probe: "false"
  # If you want cilium monitor to aggregate tracing for packets, set this level
  # to "low", "medium", or "maximum". The higher the level, the less packets
  # that will be seen in monitor output.
  monitor-aggregation: medium

  # The monitor aggregation interval governs the typical time between monitor
  # notification events for each allowed connection.
  #
  # Only effective when monitor aggregation is set to "medium" or higher.
  monitor-aggregation-interval: "5s"

  # The monitor aggregation flags determine which TCP flags which, upon the
  # first observation, cause monitor notifications to be generated.
  #
  # Only effective when monitor aggregation is set to "medium" or higher.
  monitor-aggregation-flags: all
  # Specifies the ratio (0.0-1.0] of total system memory to use for dynamic
  # sizing of the TCP CT, non-TCP CT, NAT and policy BPF maps.
  bpf-map-dynamic-size-ratio: "0.0025"
  # bpf-policy-map-max specifies the maximum number of entries in endpoint
  # policy map (per endpoint)
  bpf-policy-map-max: "16384"
  # bpf-lb-map-max specifies the maximum number of entries in bpf lb service,
  # backend and affinity maps.
  bpf-lb-map-max: "65536"
  bpf-lb-external-clusterip: "false"

  # Pre-allocation of map entries allows per-packet latency to be reduced, at
  # the expense of up-front memory allocation for the entries in the maps. The
  # default value below will minimize memory usage in the default installation;
  # users who are sensitive to latency may consider setting this to "true".
  #
  # This option was introduced in Cilium 1.4. Cilium 1.3 and earlier ignore
  # this option and behave as though it is set to "true".
  #
  # If this value is modified, then during the next Cilium startup the restore
  # of existing endpoints and tracking of ongoing connections may be disrupted.
  # As a result, reply packets may be dropped and the load-balancing decisions
  # for established connections may change.
  #
  # If this option is set to "false" during an upgrade from 1.3 or earlier to
  # 1.4 or later, then it may cause one-time disruptions during the upgrade.
  preallocate-bpf-maps: "false"

  # Regular expression matching compatible Istio sidecar istio-proxy
  # container image names
  sidecar-istio-proxy-image: "cilium/istio_proxy"

  # Name of the cluster. Only relevant when building a mesh of clusters.
  cluster-name: default
  # Unique ID of the cluster. Must be unique across all conneted clusters and
  # in the range of 1 and 255. Only relevant when building a mesh of clusters.
  cluster-id: "0"

  # Encapsulation mode for communication between nodes
  # Possible values:
  #   - disabled
  #   - vxlan (default)
  #   - geneve
  # Default case
  routing-mode: "tunnel"
  tunnel-protocol: "vxlan"


  # Enables L7 proxy for L7 policy enforcement and visibility
  enable-l7-proxy: "true"

  enable-ipv4-masquerade: "true"
  enable-ipv4-big-tcp: "false"
  enable-ipv6-big-tcp: "false"
  enable-ipv6-masquerade: "true"

  enable-xt-socket-fallback: "true"
  install-no-conntrack-iptables-rules: "false"

  auto-direct-node-routes: "false"
  enable-local-redirect-policy: "false"

  kube-proxy-replacement: "false"
  kube-proxy-replacement-healthz-bind-address: ""
  bpf-lb-sock: "false"
  enable-host-port: "false"
  enable-external-ips: "false"
  enable-node-port: "false"
  enable-health-check-nodeport: "true"
  node-port-bind-protection: "true"
  enable-auto-protect-node-port-range: "true"
  enable-svc-source-range-check: "true"
  enable-l2-neigh-discovery: "true"
  arping-refresh-period: "30s"
  enable-k8s-networkpolicy: "true"
  # Tell the agent to generate and write a CNI configuration file
  write-cni-conf-when-ready: /host/etc/cni/net.d/05-cilium.conflist
  cni-exclusive: "true"
  cni-log-file: "/var/run/cilium/cilium-cni.log"
  enable-endpoint-health-checking: "true"
  enable-health-checking: "true"
  enable-well-known-identities: "false"
  enable-remote-node-identity: "true"
  synchronize-k8s-nodes: "true"
  operator-api-serve-addr: "127.0.0.1:9234"
  # Enable Hubble gRPC service.
  enable-hubble: "true"
  # UNIX domain socket for Hubble server to listen to.
  hubble-socket-path: "/var/run/cilium/hubble.sock"
  # An additional address for Hubble server to listen to (e.g. ":4244").
  hubble-listen-address: ":4244"
  hubble-disable-tls: "false"
  hubble-tls-cert-file: /var/lib/cilium/tls/hubble/server.crt
  hubble-tls-key-file: /var/lib/cilium/tls/hubble/server.key
  hubble-tls-client-ca-files: /var/lib/cilium/tls/hubble/client-ca.crt
  ipam: "cluster-pool"
  ipam-cilium-node-update-rate: "15s"
  cluster-pool-ipv4-cidr: "10.0.0.0/8"
  cluster-pool-ipv4-mask-size: "24"
  disable-cnp-status-updates: "true"
  cnp-node-status-gc-interval: "0s"
  egress-gateway-reconciliation-trigger-interval: "1s"
  enable-vtep: "false"
  vtep-endpoint: ""
  vtep-cidr: ""
  vtep-mask: ""
  vtep-mac: ""
  enable-bgp-control-plane: "false"
  procfs: "/host/proc"
  bpf-root: "/sys/fs/bpf"
  cgroup-root: "/run/cilium/cgroupv2"
  enable-k8s-terminating-endpoint: "true"
  enable-sctp: "false"
  k8s-client-qps: "5"
  k8s-client-burst: "10"
  remove-cilium-node-taints: "true"
  set-cilium-node-taints: "true"
  set-cilium-is-up-condition: "true"
  unmanaged-pod-watcher-interval: "15"
  tofqdns-dns-reject-response-code: "refused"
  tofqdns-enable-dns-compression: "true"
  tofqdns-endpoint-max-ip-per-hostname: "50"
  tofqdns-idle-connection-grace-period: "0s"
  tofqdns-max-deferred-connection-deletes: "10000"
  tofqdns-proxy-response-max-delay: "100ms"
  agent-not-ready-taint-key: "node.cilium.io/agent-not-ready"

  mesh-auth-enabled: "true"
  mesh-auth-queue-size: "1024"
  mesh-auth-rotated-identities-queue-size: "1024"
  mesh-auth-gc-interval: "5m0s"

  proxy-connect-timeout: "2"
  proxy-max-requests-per-connection: "0"
  proxy-max-connection-duration-seconds: "0"

  external-envoy-proxy: "false"
---
# Source: cilium/templates/cilium-agent/clusterrole.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cilium
  labels:
    app.kubernetes.io/part-of: cilium
rules:
- apiGroups:
  - networking.k8s.io
  resources:
  - networkpolicies
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - discovery.k8s.io
  resources:
  - endpointslices
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - namespaces
  - services
  - pods
  - endpoints
  - nodes
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - apiextensions.k8s.io
  resources:
  - customresourcedefinitions
  verbs:
  - list
  - watch
  # This is used when validating policies in preflight. This will need to stay
  # until we figure out how to avoid "get" inside the preflight, and then
  # should be removed ideally.
  - get
- apiGroups:
  - cilium.io
  resources:
  - ciliumloadbalancerippools
  - ciliumbgppeeringpolicies
  - ciliumclusterwideenvoyconfigs
  - ciliumclusterwidenetworkpolicies
  - ciliumegressgatewaypolicies
  - ciliumendpoints
  - ciliumendpointslices
  - ciliumenvoyconfigs
  - ciliumidentities
  - ciliumlocalredirectpolicies
  - ciliumnetworkpolicies
  - ciliumnodes
  - ciliumnodeconfigs
  - ciliumcidrgroups
  - ciliuml2announcementpolicies
  - ciliumpodippools
  verbs:
  - list
  - watch
- apiGroups:
  - cilium.io
  resources:
  - ciliumidentities
  - ciliumendpoints
  - ciliumnodes
  verbs:
  - create
- apiGroups:
  - cilium.io
  # To synchronize garbage collection of such resources
  resources:
  - ciliumidentities
  verbs:
  - update
- apiGroups:
  - cilium.io
  resources:
  - ciliumendpoints
  verbs:
  - delete
  - get
- apiGroups:
  - cilium.io
  resources:
  - ciliumnodes
  - ciliumnodes/status
  verbs:
  - get
  - update
- apiGroups:
  - cilium.io
  resources:
  - ciliumnetworkpolicies/status
  - ciliumclusterwidenetworkpolicies/status
  - ciliumendpoints/status
  - ciliumendpoints
  - ciliuml2announcementpolicies/status
  verbs:
  - patch
---
# Source: cilium/templates/cilium-operator/clusterrole.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cilium-operator
  labels:
    app.kubernetes.io/part-of: cilium
rules:
- apiGroups:
  - ""
  resources:
  - pods
  verbs:
  - get
  - list
  - watch
  # to automatically delete [core|kube]dns pods so that are starting to being
  # managed by Cilium
  - delete
- apiGroups:
  - ""
  resources:
  - nodes
  verbs:
  - list
  - watch
- apiGroups:
  - ""
  resources:
  # To remove node taints
  - nodes
  # To set NetworkUnavailable false on startup
  - nodes/status
  verbs:
  - patch
- apiGroups:
  - discovery.k8s.io
  resources:
  - endpointslices
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  # to perform LB IP allocation for BGP
  - services/status
  verbs:
  - update
  - patch
- apiGroups:
  - ""
  resources:
  # to check apiserver connectivity
  - namespaces
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  # to perform the translation of a CNP that contains `ToGroup` to its endpoints
  - services
  - endpoints
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - cilium.io
  resources:
  - ciliumnetworkpolicies
  - ciliumclusterwidenetworkpolicies
  verbs:
  # Create auto-generated CNPs and CCNPs from Policies that have 'toGroups'
  - create
  - update
  - deletecollection
  # To update the status of the CNPs and CCNPs
  - patch
  - get
  - list
  - watch
- apiGroups:
  - cilium.io
  resources:
  - ciliumnetworkpolicies/status
  - ciliumclusterwidenetworkpolicies/status
  verbs:
  # Update the auto-generated CNPs and CCNPs status.
  - patch
  - update
- apiGroups:
  - cilium.io
  resources:
  - ciliumendpoints
  - ciliumidentities
  verbs:
  # To perform garbage collection of such resources
  - delete
  - list
  - watch
- apiGroups:
  - cilium.io
  resources:
  - ciliumidentities
  verbs:
  # To synchronize garbage collection of such resources
  - update
- apiGroups:
  - cilium.io
  resources:
  - ciliumnodes
  verbs:
  - create
  - update
  - get
  - list
  - watch
    # To perform CiliumNode garbage collector
  - delete
- apiGroups:
  - cilium.io
  resources:
  - ciliumnodes/status
  verbs:
  - update
- apiGroups:
  - cilium.io
  resources:
  - ciliumendpointslices
  - ciliumenvoyconfigs
  verbs:
  - create
  - update
  - get
  - list
  - watch
  - delete
  - patch
- apiGroups:
  - apiextensions.k8s.io
  resources:
  - customresourcedefinitions
  verbs:
  - create
  - get
  - list
  - watch
- apiGroups:
  - apiextensions.k8s.io
  resources:
  - customresourcedefinitions
  verbs:
  - update
  resourceNames:
  - ciliumloadbalancerippools.cilium.io
  - ciliumbgppeeringpolicies.cilium.io
  - ciliumclusterwideenvoyconfigs.cilium.io
  - ciliumclusterwidenetworkpolicies.cilium.io
  - ciliumegressgatewaypolicies.cilium.io
  - ciliumendpoints.cilium.io
  - ciliumendpointslices.cilium.io
  - ciliumenvoyconfigs.cilium.io
  - ciliumexternalworkloads.cilium.io
  - ciliumidentities.cilium.io
  - ciliumlocalredirectpolicies.cilium.io
  - ciliumnetworkpolicies.cilium.io
  - ciliumnodes.cilium.io
  - ciliumnodeconfigs.cilium.io
  - ciliumcidrgroups.cilium.io
  - ciliuml2announcementpolicies.cilium.io
  - ciliumpodippools.cilium.io
- apiGroups:
  - cilium.io
  resources:
  - ciliumloadbalancerippools
  - ciliumpodippools
  verbs:
  - get
  - list
  - watch
- apiGroups:
    - cilium.io
  resources:
    - ciliumpodippools
  verbs:
    - create
- apiGroups:
  - cilium.io
  resources:
  - ciliumloadbalancerippools/status
  verbs:
  - patch
# For cilium-operator running in HA mode.
#
# Cilium operator running in HA mode requires the use of ResourceLock for Leader Election
# between multiple running instances.
# The preferred way of doing this is to use LeasesResourceLock as edits to Leases are less
# common and fewer objects in the cluster watch "all Leases".
- apiGroups:
  - coordination.k8s.io
  resources:
  - leases
  verbs:
  - create
  - get
  - update
---
# Source: cilium/templates/cilium-agent/clusterrolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cilium
  labels:
    app.kubernetes.io/part-of: cilium
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cilium
subjects:
- kind: ServiceAccount
  name: "cilium"
  namespace: kube-system
---
# Source: cilium/templates/cilium-operator/clusterrolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cilium-operator
  labels:
    app.kubernetes.io/part-of: cilium
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cilium-operator
subjects:
- kind: ServiceAccount
  name: "cilium-operator"
  namespace: kube-system
---
# Source: cilium/templates/cilium-agent/role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: cilium-config-agent
  namespace: kube-system
  labels:
    app.kubernetes.io/part-of: cilium
rules:
- apiGroups:
  - ""
  resources:
  - configmaps
  verbs:
  - get
  - list
  - watch
---
# Source: cilium/templates/cilium-agent/rolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: cilium-config-agent
  namespace: kube-system
  labels:
    app.kubernetes.io/part-of: cilium
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: cilium-config-agent
subjects:
  - kind: ServiceAccount
    name: "cilium"
    namespace: kube-system
---
# Source: cilium/templates/hubble/peer-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: hubble-peer
  namespace: kube-system
  labels:
    k8s-app: cilium
    app.kubernetes.io/part-of: cilium
    app.kubernetes.io/name: hubble-peer
spec:
  selector:
    k8s-app: cilium
  ports:
  - name: peer-service
    port: 443
    protocol: TCP
    targetPort: 4244
  internalTrafficPolicy: Local
---
# Source: cilium/templates/cilium-agent/daemonset.yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: cilium
  namespace: kube-system
  labels:
    k8s-app: cilium
    app.kubernetes.io/part-of: cilium
    app.kubernetes.io/name: cilium-agent
spec:
  selector:
    matchLabels:
      k8s-app: cilium
  updateStrategy:
    rollingUpdate:
      maxUnavailable: 2
    type: RollingUpdate
  template:
    metadata:
      annotations:
        # Set app AppArmor's profile to "unconfined". The value of this annotation
        # can be modified as long users know which profiles they have available
        # in AppArmor.
        container.apparmor.security.beta.kubernetes.io/cilium-agent: "unconfined"
        container.apparmor.security.beta.kubernetes.io/clean-cilium-state: "unconfined"
        container.apparmor.security.beta.kubernetes.io/mount-cgroup: "unconfined"
        container.apparmor.security.beta.kubernetes.io/apply-sysctl-overwrites: "unconfined"
      labels:
        k8s-app: cilium
        app.kubernetes.io/name: cilium-agent
        app.kubernetes.io/part-of: cilium
    spec:
      containers:
      - name: cilium-agent
        image: "quay.io/cilium/cilium:v1.14.2"
        imagePullPolicy: IfNotPresent
        command:
        - cilium-agent
        args:
        - --config-dir=/tmp/cilium/config-map
        startupProbe:
          httpGet:
            host: "127.0.0.1"
            path: /healthz
            port: 9879
            scheme: HTTP
            httpHeaders:
            - name: "brief"
              value: "true"
          failureThreshold: 105
          periodSeconds: 2
          successThreshold: 1
        livenessProbe:
          httpGet:
            host: "127.0.0.1"
            path: /healthz
            port: 9879
            scheme: HTTP
            httpHeaders:
            - name: "brief"
              value: "true"
          periodSeconds: 30
          successThreshold: 1
          failureThreshold: 10
          timeoutSeconds: 5
        readinessProbe:
          httpGet:
            host: "127.0.0.1"
            path: /healthz
            port: 9879
            scheme: HTTP
            httpHeaders:
            - name: "brief"
              value: "true"
          periodSeconds: 30
          successThreshold: 1
          failureThreshold: 3
          timeoutSeconds: 5
        env:
        - name: K8S_NODE_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: spec.nodeName
        - name: CILIUM_K8S_NAMESPACE
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
        - name: CILIUM_CLUSTERMESH_CONFIG
          value: /var/lib/cilium/clustermesh/
        lifecycle:
          preStop:
            exec:
              command:
              - /cni-uninstall.sh
        securityContext:
          seLinuxOptions:
            level: s0
            type: spc_t
          capabilities:
            add:
              - CHOWN
              - KILL
              - NET_ADMIN
              - NET_RAW
              - IPC_LOCK
              - SYS_MODULE
              - SYS_ADMIN
              - SYS_RESOURCE
              - DAC_OVERRIDE
              - FOWNER
              - SETGID
              - SETUID
            drop:
              - ALL
        terminationMessagePolicy: FallbackToLogsOnError
        volumeMounts:
        # Unprivileged containers need to mount /proc/sys/net from the host
        # to have write access
        - mountPath: /host/proc/sys/net
          name: host-proc-sys-net
        # Unprivileged containers need to mount /proc/sys/kernel from the host
        # to have write access
        - mountPath: /host/proc/sys/kernel
          name: host-proc-sys-kernel
        - name: bpf-maps
          mountPath: /sys/fs/bpf
          # Unprivileged containers can't set mount propagation to bidirectional
          # in this case we will mount the bpf fs from an init container that
          # is privileged and set the mount propagation from host to container
          # in Cilium.
          mountPropagation: HostToContainer
        - name: cilium-run
          mountPath: /var/run/cilium
        - name: etc-cni-netd
          mountPath: /host/etc/cni/net.d
        - name: clustermesh-secrets
          mountPath: /var/lib/cilium/clustermesh
          readOnly: true
          # Needed to be able to load kernel modules
        - name: lib-modules
          mountPath: /lib/modules
          readOnly: true
        - name: xtables-lock
          mountPath: /run/xtables.lock
        - name: hubble-tls
          mountPath: /var/lib/cilium/tls/hubble
          readOnly: true
        - name: tmp
          mountPath: /tmp
      initContainers:
      - name: config
        image: "quay.io/cilium/cilium:v1.14.2"
        imagePullPolicy: IfNotPresent
        command:
        - cilium
        - build-config
        env:
        - name: K8S_NODE_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: spec.nodeName
        - name: CILIUM_K8S_NAMESPACE
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
        volumeMounts:
        - name: tmp
          mountPath: /tmp
        terminationMessagePolicy: FallbackToLogsOnError
      # Required to mount cgroup2 filesystem on the underlying Kubernetes node.
      # We use nsenter command with host's cgroup and mount namespaces enabled.
      - name: mount-cgroup
        image: "quay.io/cilium/cilium:v1.14.2"
        imagePullPolicy: IfNotPresent
        env:
        - name: CGROUP_ROOT
          value: /run/cilium/cgroupv2
        - name: BIN_PATH
          value: /opt/cni/bin
        command:
        - sh
        - -ec
        # The statically linked Go program binary is invoked to avoid any
        # dependency on utilities like sh and mount that can be missing on certain
        # distros installed on the underlying host. Copy the binary to the
        # same directory where we install cilium cni plugin so that exec permissions
        # are available.
        - |
          cp /usr/bin/cilium-mount /hostbin/cilium-mount;
          nsenter --cgroup=/hostproc/1/ns/cgroup --mount=/hostproc/1/ns/mnt "$BIN_PATH/cilium-mount" $CGROUP_ROOT;
          rm /hostbin/cilium-mount
        volumeMounts:
        - name: hostproc
          mountPath: /hostproc
        - name: cni-path
          mountPath: /hostbin
        terminationMessagePolicy: FallbackToLogsOnError
        securityContext:
          seLinuxOptions:
            level: s0
            type: spc_t
          capabilities:
            add:
              - SYS_ADMIN
              - SYS_CHROOT
              - SYS_PTRACE
            drop:
              - ALL
      - name: apply-sysctl-overwrites
        image: "quay.io/cilium/cilium:v1.14.2"
        imagePullPolicy: IfNotPresent
        env:
        - name: BIN_PATH
          value: /opt/cni/bin
        command:
        - sh
        - -ec
        # The statically linked Go program binary is invoked to avoid any
        # dependency on utilities like sh that can be missing on certain
        # distros installed on the underlying host. Copy the binary to the
        # same directory where we install cilium cni plugin so that exec permissions
        # are available.
        - |
          cp /usr/bin/cilium-sysctlfix /hostbin/cilium-sysctlfix;
          nsenter --mount=/hostproc/1/ns/mnt "$BIN_PATH/cilium-sysctlfix";
          rm /hostbin/cilium-sysctlfix
        volumeMounts:
        - name: hostproc
          mountPath: /hostproc
        - name: cni-path
          mountPath: /hostbin
        terminationMessagePolicy: FallbackToLogsOnError
        securityContext:
          seLinuxOptions:
            level: s0
            type: spc_t
          capabilities:
            add:
              - SYS_ADMIN
              - SYS_CHROOT
              - SYS_PTRACE
            drop:
              - ALL
      # Mount the bpf fs if it is not mounted. We will perform this task
      # from a privileged container because the mount propagation bidirectional
      # only works from privileged containers.
      - name: mount-bpf-fs
        image: "quay.io/cilium/cilium:v1.14.2"
        imagePullPolicy: IfNotPresent
        args:
        - 'mount | grep "/sys/fs/bpf type bpf" || mount -t bpf bpf /sys/fs/bpf'
        command:
        - /bin/bash
        - -c
        - --
        terminationMessagePolicy: FallbackToLogsOnError
        securityContext:
          privileged: true
        volumeMounts:
        - name: bpf-maps
          mountPath: /sys/fs/bpf
          mountPropagation: Bidirectional
      - name: clean-cilium-state
        image: "quay.io/cilium/cilium:v1.14.2"
        imagePullPolicy: IfNotPresent
        command:
        - /init-container.sh
        env:
        - name: CILIUM_ALL_STATE
          valueFrom:
            configMapKeyRef:
              name: cilium-config
              key: clean-cilium-state
              optional: true
        - name: CILIUM_BPF_STATE
          valueFrom:
            configMapKeyRef:
              name: cilium-config
              key: clean-cilium-bpf-state
              optional: true
        terminationMessagePolicy: FallbackToLogsOnError
        securityContext:
          seLinuxOptions:
            level: s0
            type: spc_t
          capabilities:
            add:
              - NET_ADMIN
              - SYS_MODULE
              - SYS_ADMIN
              - SYS_RESOURCE
            drop:
              - ALL
        volumeMounts:
        - name: bpf-maps
          mountPath: /sys/fs/bpf
          # Required to mount cgroup filesystem from the host to cilium agent pod
        - name: cilium-cgroup
          mountPath: /run/cilium/cgroupv2
          mountPropagation: HostToContainer
        - name: cilium-run
          mountPath: /var/run/cilium
        resources:
          requests:
            cpu: 100m
            memory: 100Mi # wait-for-kube-proxy
      # Install the CNI binaries in an InitContainer so we don't have a writable host mount in the agent
      - name: install-cni-binaries
        image: "quay.io/cilium/cilium:v1.14.2"
        imagePullPolicy: IfNotPresent
        command:
          - "/install-plugin.sh"
        resources:
          requests:
            cpu: 100m
            memory: 10Mi
        securityContext:
          seLinuxOptions:
            level: s0
            type: spc_t
          capabilities:
            drop:
              - ALL
        terminationMessagePolicy: FallbackToLogsOnError
        volumeMounts:
          - name: cni-path
            mountPath: /host/opt/cni/bin # .Values.cni.install
      restartPolicy: Always
      priorityClassName: system-node-critical
      serviceAccount: "cilium"
      serviceAccountName: "cilium"
      automountServiceAccountToken: true
      terminationGracePeriodSeconds: 1
      hostNetwork: true
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchLabels:
                k8s-app: cilium
            topologyKey: kubernetes.io/hostname
      nodeSelector:
        kubernetes.io/os: linux
      tolerations:
        - operator: Exists
      volumes:
        # For sharing configuration between the "config" initContainer and the agent
      - name: tmp
        emptyDir: {}
        # To keep state between restarts / upgrades
      - name: cilium-run
        hostPath:
          path: /var/run/cilium
          type: DirectoryOrCreate
        # To keep state between restarts / upgrades for bpf maps
      - name: bpf-maps
        hostPath:
          path: /sys/fs/bpf
          type: DirectoryOrCreate
      # To mount cgroup2 filesystem on the host
      - name: hostproc
        hostPath:
          path: /proc
          type: Directory
      # To keep state between restarts / upgrades for cgroup2 filesystem
      - name: cilium-cgroup
        hostPath:
          path: /run/cilium/cgroupv2
          type: DirectoryOrCreate
      # To install cilium cni plugin in the host
      - name: cni-path
        hostPath:
          path:  /opt/cni/bin
          type: DirectoryOrCreate
        # To install cilium cni configuration in the host
      - name: etc-cni-netd
        hostPath:
          path: /etc/cni/net.d
          type: DirectoryOrCreate
        # To be able to load kernel modules
      - name: lib-modules
        hostPath:
          path: /lib/modules
        # To access iptables concurrently with other processes (e.g. kube-proxy)
      - name: xtables-lock
        hostPath:
          path: /run/xtables.lock
          type: FileOrCreate
        # To read the clustermesh configuration
      - name: clustermesh-secrets
        projected:
          # note: the leading zero means this number is in octal representation: do not remove it
          defaultMode: 0400
          sources:
          - secret:
              name: cilium-clustermesh
              optional: true
              # note: items are not explicitly listed here, since the entries of this secret
              # depend on the peers configured, and that would cause a restart of all agents
              # at every addition/removal. Leaving the field empty makes each secret entry
              # to be automatically projected into the volume as a file whose name is the key.
          - secret:
              name: clustermesh-apiserver-remote-cert
              optional: true
              items:
              - key: tls.key
                path: common-etcd-client.key
              - key: tls.crt
                path: common-etcd-client.crt
              - key: ca.crt
                path: common-etcd-client-ca.crt
      - name: host-proc-sys-net
        hostPath:
          path: /proc/sys/net
          type: Directory
      - name: host-proc-sys-kernel
        hostPath:
          path: /proc/sys/kernel
          type: Directory
      - name: hubble-tls
        projected:
          # note: the leading zero means this number is in octal representation: do not remove it
          defaultMode: 0400
          sources:
          - secret:
              name: hubble-server-certs
              optional: true
              items:
              - key: tls.crt
                path: server.crt
              - key: tls.key
                path: server.key
              - key: ca.crt
                path: client-ca.crt
---
# Source: cilium/templates/cilium-operator/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cilium-operator
  namespace: kube-system
  labels:
    io.cilium/app: operator
    name: cilium-operator
    app.kubernetes.io/part-of: cilium
    app.kubernetes.io/name: cilium-operator
spec:
  # See docs on ServerCapabilities.LeasesResourceLock in file pkg/k8s/version/version.go
  # for more details.
  replicas: 2
  selector:
    matchLabels:
      io.cilium/app: operator
      name: cilium-operator
  # ensure operator update on single node k8s clusters, by using rolling update with maxUnavailable=100% in case
  # of one replica and no user configured Recreate strategy.
  # otherwise an update might get stuck due to the default maxUnavailable=50% in combination with the
  # podAntiAffinity which prevents deployments of multiple operator replicas on the same node.
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 50%
    type: RollingUpdate
  template:
    metadata:
      annotations:
      labels:
        io.cilium/app: operator
        name: cilium-operator
        app.kubernetes.io/part-of: cilium
        app.kubernetes.io/name: cilium-operator
    spec:
      containers:
      - name: cilium-operator
        image: "quay.io/cilium/operator-generic:v1.14.2"
        imagePullPolicy: IfNotPresent
        command:
        - cilium-operator-generic
        args:
        - --config-dir=/tmp/cilium/config-map
        - --debug=$(CILIUM_DEBUG)
        env:
        - name: K8S_NODE_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: spec.nodeName
        - name: CILIUM_K8S_NAMESPACE
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
        - name: CILIUM_DEBUG
          valueFrom:
            configMapKeyRef:
              key: debug
              name: cilium-config
              optional: true
        livenessProbe:
          httpGet:
            host: "127.0.0.1"
            path: /healthz
            port: 9234
            scheme: HTTP
          initialDelaySeconds: 60
          periodSeconds: 10
          timeoutSeconds: 3
        readinessProbe:
          httpGet:
            host: "127.0.0.1"
            path: /healthz
            port: 9234
            scheme: HTTP
          initialDelaySeconds: 0
          periodSeconds: 5
          timeoutSeconds: 3
          failureThreshold: 5
        volumeMounts:
        - name: cilium-config-path
          mountPath: /tmp/cilium/config-map
          readOnly: true
        terminationMessagePolicy: FallbackToLogsOnError
      hostNetwork: true
      restartPolicy: Always
      priorityClassName: system-cluster-critical
      serviceAccount: "cilium-operator"
      serviceAccountName: "cilium-operator"
      automountServiceAccountToken: true
      # In HA mode, cilium-operator pods must not be scheduled on the same
      # node as they will clash with each other.
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchLabels:
                io.cilium/app: operator
            topologyKey: kubernetes.io/hostname
      nodeSelector:
        kubernetes.io/os: linux
      tolerations:
        - operator: Exists
      volumes:
        # To read the configuration from the config map
      - name: cilium-config-path
        configMap:
          name: cilium-config
---
# Source: cilium/templates/cilium-secrets-namespace.yaml
# Only create the namespace if it's different from Ingress secret namespace or Ingress is not enabled.

# Only create the namespace if it's different from Ingress and Gateway API secret namespaces (if enabled).
