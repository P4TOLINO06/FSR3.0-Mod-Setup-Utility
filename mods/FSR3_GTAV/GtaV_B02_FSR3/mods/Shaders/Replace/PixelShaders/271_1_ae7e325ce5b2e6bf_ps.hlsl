// ---- FNV Hash ae7e325ce5b2e6bf

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t15 : register(t15);

SamplerState s15_s : register(s15);


cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = float2(0.333333313,0.333333313) * v0.xy;
  r0.zw = cmp(r0.xy >= -r0.xy);
  r0.xy = frac(abs(r0.xy));
  r0.xy = r0.zw ? r0.xy : -r0.xy;
  r0.x = r0.x * 3 + 1;
  r0.x = r0.y * 9 + r0.x;
  r0.y = 0.111111097 * r0.x;
  r0.yz = v2.zw * r0.yy + v2.xy;
  r0.y = t15.SampleLevel(s15_s, r0.yz, 0).x;
  r0.y = 1.5 * r0.y;
  r1.xyzw = r0.xxxx * float4(0.111111097,0.111111097,0.111111097,0.111111097) + float4(1,2,3,4);
  r2.xyzw = v2.zwzw * r1.xxyy + v2.xyxy;
  r1.xyzw = v2.zwzw * r1.zzww + v2.xyxy;
  r0.z = t15.SampleLevel(s15_s, r2.xy, 0).x;
  r0.w = t15.SampleLevel(s15_s, r2.zw, 0).x;
  r0.y = r0.z * 1.44000006 + r0.y;
  r0.y = r0.w * 1.38 + r0.y;
  r0.z = t15.SampleLevel(s15_s, r1.xy, 0).x;
  r0.w = t15.SampleLevel(s15_s, r1.zw, 0).x;
  r0.y = r0.z * 1.32000005 + r0.y;
  r0.y = r0.w * 1.25999999 + r0.y;
  r1.xyzw = r0.xxxx * float4(0.111111097,0.111111097,0.111111097,0.111111097) + float4(5,6,7,8);
  r2.xyzw = v2.zwzw * r1.xxyy + v2.xyxy;
  r1.xyzw = v2.zwzw * r1.zzww + v2.xyxy;
  r0.z = t15.SampleLevel(s15_s, r2.xy, 0).x;
  r0.w = t15.SampleLevel(s15_s, r2.zw, 0).x;
  r0.y = r0.z * 1.20000005 + r0.y;
  r0.y = r0.w * 1.13999999 + r0.y;
  r0.z = t15.SampleLevel(s15_s, r1.xy, 0).x;
  r0.w = t15.SampleLevel(s15_s, r1.zw, 0).x;
  r0.y = r0.z * 1.08000004 + r0.y;
  r0.y = r0.w * 1.01999998 + r0.y;
  r1.xyzw = r0.xxxx * float4(0.111111097,0.111111097,0.111111097,0.111111097) + float4(9,10,11,12);
  r0.xzw = r0.xxx * float3(0.111111097,0.111111097,0.111111097) + float3(13,14,15);
  r2.xyzw = v2.zwzw * r1.xxyy + v2.xyxy;
  r1.xyzw = v2.zwzw * r1.zzww + v2.xyxy;
  r2.x = t15.SampleLevel(s15_s, r2.xy, 0).x;
  r2.y = t15.SampleLevel(s15_s, r2.zw, 0).x;
  r0.y = r2.x * 0.959999979 + r0.y;
  r0.y = r2.y * 0.899999976 + r0.y;
  r1.x = t15.SampleLevel(s15_s, r1.xy, 0).x;
  r1.y = t15.SampleLevel(s15_s, r1.zw, 0).x;
  r0.y = r1.x * 0.839999974 + r0.y;
  r0.y = r1.y * 0.779999971 + r0.y;
  r1.xyzw = v2.zwzw * r0.xxzz + v2.xyxy;
  r0.xz = v2.zw * r0.ww + v2.xy;
  r0.x = t15.SampleLevel(s15_s, r0.xz, 0).x;
  r0.z = t15.SampleLevel(s15_s, r1.xy, 0).x;
  r0.w = t15.SampleLevel(s15_s, r1.zw, 0).x;
  r0.y = r0.z * 0.720000029 + r0.y;
  r0.y = r0.w * 0.660000026 + r0.y;
  r0.x = r0.x * 0.600000024 + r0.y;
  r0.y = t15.SampleLevel(s15_s, v2.xy, 0).x;
  r0.x = r0.y * 1.5 + r0.x;
  r0.xy = float2(0.0595238097,0.100000001) * r0.xy;
  r0.x = max(r0.y, r0.x);
  r0.y = dot(v1.xy, v1.xy);
  r0.y = sqrt(r0.y);
  r0.y = 1 + -r0.y;
  r0.x = r0.y * r0.x;
  r0.x = 0.5 * r0.x;
  r0.x = max(0, r0.x);
  r0.x = log2(r0.x);
  r0.x = 0.25 * r0.x;
  o0.xyz = exp2(r0.xxx);
  o0.w = 1;
  return;
}