// ---- FNV Hash b12906daf3e4f802

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 13 01:20:59 2023

cbuffer _Globals : register(b0)
{
  float4 Timer : packoffset(c0);
  float4 tempF1 : packoffset(c1);
  float4 tempF2 : packoffset(c2);
  float4 tempF3 : packoffset(c3);
  float4 ScreenSize : packoffset(c4);
  float4 SourceSize : packoffset(c5);
  float4 DynamicScaling : packoffset(c6);
  float4 Parameters01 : packoffset(c7);
  float4 Parameters02 : packoffset(c8);
  float4 Parameters03 : packoffset(c9);
  float4 Parameters04 : packoffset(c10);
  float4 Parameters05 : packoffset(c11);
  float4 Parameters06 : packoffset(c12);
  float4 Parameters07 : packoffset(c13);
  float4 Parameters08 : packoffset(c14);
  float4 Matrix01[4] : packoffset(c15);
  float4 Matrix02[4] : packoffset(c19);
  float4 Matrix03[4] : packoffset(c23);
  float4 Matrix04[4] : packoffset(c27);
  float4 Matrix05[4] : packoffset(c31);
  float SSAOsplitcount : packoffset(c35) = {2};
}

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

SamplerState Sampler8_s : register(s8);
SamplerState Sampler9_s : register(s9);
Texture2D<float4> Texture0 : register(t0);
Texture2D<float4> Texture1 : register(t1);
Texture2D<float4> Texture2 : register(t2);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_POSITION0,
  float2 v1 : TEXCOORD0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = Texture0.Sample(Sampler8_s, v1.xy).x;
  r0.y = cmp(r0.x >= 1);
  if (r0.y != 0) discard;
  r1.y = ScreenSize.y * ScreenSize.z;
  r2.xyzw = Texture2.Sample(Sampler8_s, v1.xy).xyzw;
  r0.yzw = Texture1.Sample(Sampler8_s, v1.xy).xyz;
  r0.yzw = r0.yzw * float3(2,2,2) + float3(-1,-1,-1);
  r0.x = 1 + -r0.x;
  r0.x = 1 / r0.x;
  r3.xyz = r2.xyz * r2.xyz;
  r2.xyz = r3.xyz * r2.xyz;
  r1.x = ScreenSize.y;
  r3.xyzw = r1.xyxy * float4(-0.5,-1.5,1.5,-0.5) + v1.xyxy;
  r1.z = Texture0.SampleLevel(Sampler9_s, r3.xy, 0).x;
  r4.xyzw = Texture2.SampleLevel(Sampler9_s, r3.xy, 0).xyzw;
  r5.xyz = Texture1.SampleLevel(Sampler9_s, r3.xy, 0).xyz;
  r6.xyz = r4.xyz * r4.xyz;
  r6.xyz = r6.xyz * r4.xyz;
  r4.xyz = float3(25,25,25) * r6.xyz;
  r1.z = 1 + -r1.z;
  r5.xyz = r5.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r1.w = saturate(dot(r5.xyz, r0.yzw));
  r1.w = r1.w * 21 + -20;
  r1.w = max(0, r1.w);
  r1.z = -r0.x * r1.z + 1;
  r3.x = 18 * r1.z;
  r3.x = -abs(r3.x) * 0.75 + 0.5;
  r1.z = saturate(-r1.z * 4.5 + r3.x);
  r1.z = r1.w * r1.z + 0.00600000005;
  r1.z = min(1, r1.z);
  r4.xyzw = r4.xyzw * r1.zzzz;
  r2.xyzw = r2.xyzw * float4(3.125,3.125,3.125,0.125) + r4.xyzw;
  r1.z = 0.125 + r1.z;
  r1.w = Texture0.SampleLevel(Sampler9_s, r3.zw, 0).x;
  r4.xyzw = Texture2.SampleLevel(Sampler9_s, r3.zw, 0).xyzw;
  r3.xyz = Texture1.SampleLevel(Sampler9_s, r3.zw, 0).xyz;
  r5.xyz = r4.xyz * r4.xyz;
  r5.xyz = r5.xyz * r4.xyz;
  r4.xyz = float3(25,25,25) * r5.xyz;
  r1.w = 1 + -r1.w;
  r3.xyz = r3.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r3.x = saturate(dot(r3.xyz, r0.yzw));
  r3.x = r3.x * 21 + -20;
  r3.x = max(0, r3.x);
  r1.w = -r0.x * r1.w + 1;
  r3.y = 18 * r1.w;
  r3.y = -abs(r3.y) * 0.75 + 0.5;
  r1.w = saturate(-r1.w * 4.5 + r3.y);
  r1.w = r3.x * r1.w + 0.00600000005;
  r1.w = min(1, r1.w);
  r2.xyzw = r4.xyzw * r1.wwww + r2.xyzw;
  r1.z = r1.z + r1.w;
  r3.xyzw = r1.xyxy * float4(0.5,1.5,-1.5,0.5) + v1.xyxy;
  r1.x = Texture0.SampleLevel(Sampler9_s, r3.xy, 0).x;
  r4.xyzw = Texture2.SampleLevel(Sampler9_s, r3.xy, 0).xyzw;
  r5.xyz = Texture1.SampleLevel(Sampler9_s, r3.xy, 0).xyz;
  r6.xyz = r4.xyz * r4.xyz;
  r6.xyz = r6.xyz * r4.xyz;
  r4.xyz = float3(25,25,25) * r6.xyz;
  r1.x = 1 + -r1.x;
  r5.xyz = r5.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r1.y = saturate(dot(r5.xyz, r0.yzw));
  r1.y = r1.y * 21 + -20;
  r1.y = max(0, r1.y);
  r1.x = -r0.x * r1.x + 1;
  r1.w = 18 * r1.x;
  r1.w = -abs(r1.w) * 0.75 + 0.5;
  r1.x = saturate(-r1.x * 4.5 + r1.w);
  r1.x = r1.y * r1.x + 0.00600000005;
  r1.x = min(1, r1.x);
  r2.xyzw = r4.xyzw * r1.xxxx + r2.xyzw;
  r1.x = r1.z + r1.x;
  r1.y = Texture0.SampleLevel(Sampler9_s, r3.zw, 0).x;
  r4.xyzw = Texture2.SampleLevel(Sampler9_s, r3.zw, 0).xyzw;
  r3.xyz = Texture1.SampleLevel(Sampler9_s, r3.zw, 0).xyz;
  r5.xyz = r4.xyz * r4.xyz;
  r5.xyz = r5.xyz * r4.xyz;
  r4.xyz = float3(25,25,25) * r5.xyz;
  r1.y = 1 + -r1.y;
  r3.xyz = r3.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r0.y = saturate(dot(r3.xyz, r0.yzw));
  r0.y = r0.y * 21 + -20;
  r0.y = max(0, r0.y);
  r0.x = -r0.x * r1.y + 1;
  r0.z = 18 * r0.x;
  r0.z = -abs(r0.z) * 0.75 + 0.5;
  r0.x = saturate(-r0.x * 4.5 + r0.z);
  r0.x = r0.y * r0.x + 0.00600000005;
  r0.x = min(1, r0.x);
  r2.xyzw = r4.xyzw * r0.xxxx + r2.xyzw;
  r0.x = r1.x + r0.x;
  r0.x = rcp(r0.x);
  r0.xyzw = r2.xyzw * r0.xxxx;
  r0.xyz = float3(0.0399999991,0.0399999991,0.0399999991) * r0.xyz;
  r0.xyz = log2(r0.xyz);
  r0.xyz = float3(0.333299994,0.333299994,0.333299994) * r0.xyz;
  r0.xyz = exp2(r0.xyz);
  r1.xy = float2(0.5,0.5) * v0.xy;
  r1.xy = frac(r1.xy);
  r1.x = r1.y * 2 + r1.x;
  r1.x = r1.x * 0.833333313 + -1;
  r1.x = 0.00240000011 * r1.x;
  r1.yzw = float3(10000,10000,10000) * r0.xyz;
  r1.yzw = min(float3(1,1,1), r1.yzw);
  o0.xyz = r1.yzw * r1.xxx + r0.xyz;
  o0.w = r0.w;
  return;
}