// ---- FNV Hash efece2e5959d5aa5

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
Texture2D<float4> Texture0 : register(t0);
Texture2D<float4> Texture1 : register(t1);
Texture2D<float4> Texture2 : register(t2);
Texture2D<float4> Texture3 : register(t3);


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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = Texture0.Sample(Sampler8_s, v1.xy).x;
  r0.y = cmp(r0.x >= 1);
  r0.zw = float2(0.25,0.25) * v0.xy;
  r0.zw = frac(r0.zw);
  r0.z = Texture3.Sample(Sampler8_s, r0.zw).w;
  if (r0.y != 0) {
    o0.xyzw = float4(0,0,0,1);
    return;
  }
  r1.y = ScreenSize.y * ScreenSize.z;
  r0.y = 1 + -r0.x;
  r0.y = max(1.00000002e-16, r0.y);
  r2.z = 1 / r0.y;
  r3.xyz = Texture1.Sample(Sampler8_s, v1.xy).xyz;
  r3.xyz = r3.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r4.x = dot(r3.xyz, Matrix04[0].xyz);
  r4.y = dot(r3.xyz, Matrix04[1].xyz);
  r4.z = dot(r3.xyz, Matrix04[2].xyz);
  r0.y = dot(r4.xyz, r4.xyz);
  r0.y = rsqrt(r0.y);
  r3.xyz = r4.xyz * r0.yyy;
  r4.xyzw = Texture2.Sample(Sampler8_s, v1.xy).xyzw;
  r5.xyz = r4.xyz * r4.xyz;
  r4.xyz = r5.xyz * r4.xyz;
  r4.xyz = float3(25,25,25) * r4.xyz;
  r0.yw = v1.xy * float2(2,2) + float2(-1,-1);
  r2.xy = r0.yw * r2.zz;
  r0.y = 6.28319979 * r0.z;
  sincos(r0.y, r5.x, r6.x);
  r1.x = ScreenSize.y;
  r0.yw = r1.xy + r1.xy;
  r1.xy = r1.xy * r0.zz;
  r0.yz = r1.xy * float2(4,4) + r0.yw;
  r0.w = 5 * Parameters02.x;
  r0.yz = r0.yz * r0.ww;
  r0.w = 0.0560000017 * r2.z;
  r0.x = cmp(0.999998987 < r0.x);
  r0.x = r0.x ? 0 : 6;
  r1.xy = float2(0.5,0.5) * Parameters01.xy;
  r7.z = 1;
  r3.xyz = float3(1,-1,-1) * r3.xyz;
  r8.xyzw = r4.xyzw;
  r9.x = r6.x;
  r9.y = r5.x;
  r1.zw = float2(1,0);
  while (true) {
    r2.w = cmp((int)r1.w >= (int)r0.x);
    if (r2.w != 0) break;
    r1.w = (int)r1.w + 1;
    r10.x = dot(r9.xy, float2(0.5,-0.865999997));
    r10.y = dot(r9.yx, float2(0.5,0.865999997));
    r5.yz = r10.xy * r0.yz + v1.xy;
    r5.yz = Parameters01.zw * r5.yz;
    r5.yz = floor(r5.yz);
    r5.yz = r5.yz * Parameters01.xy + r1.xy;
    r2.w = Texture0.SampleLevel(Sampler8_s, r5.yz, 0).x;
    r6.yz = float2(1,0.999998987) + -r2.ww;
    r2.w = max(1.00000002e-16, r6.y);
    r2.w = 1 / r2.w;
    r7.xy = r5.yz * float2(2,2) + float2(-1,-1);
    r7.xyw = -r7.xyz * r2.www + r2.xyz;
    r2.w = dot(r7.xyw, r7.xyw);
    r2.w = rsqrt(r2.w);
    r7.xyw = r7.xyw * r2.www;
    r11.xyz = Texture1.SampleLevel(Sampler8_s, r5.yz, 0).xyz;
    r11.xyz = r11.xyz * float3(2,2,2) + float3(-1,-1,-1);
    r12.x = dot(r11.xyz, Matrix04[0].xyz);
    r12.y = dot(r11.xyz, Matrix04[1].xyz);
    r12.z = dot(r11.xyz, Matrix04[2].xyz);
    r3.w = dot(r12.xyz, r12.xyz);
    r3.w = rsqrt(r3.w);
    r11.xyz = r12.xyz * r3.www;
    r3.w = dot(r3.xyz, r7.xyw);
    r3.w = 1 + -abs(r3.w);
    r3.w = max(0, r3.w);
    r3.w = r3.w * r3.w;
    r7.xyw = float3(1,-1,-1) * r11.xyz;
    r5.w = saturate(dot(r3.xyz, r7.xyw));
    r5.w = r5.w * 48 + -47;
    r5.w = max(0, r5.w);
    r2.w = saturate(r2.w * r0.w);
    r2.w = r5.w * r2.w;
    r5.w = saturate(1e+09 * r6.z);
    r2.w = r5.w * r2.w;
    r11.xyzw = Texture2.SampleLevel(Sampler8_s, r5.yz, 0).xyzw;
    r5.yzw = r11.xyz * r11.xyz;
    r5.yzw = r5.yzw * r11.xyz;
    r11.xyz = float3(25,25,25) * r5.yzw;
    r5.y = r3.w * r2.w;
    r8.xyzw = r11.xyzw * r5.yyyy + r8.xyzw;
    r1.z = r3.w * r2.w + r1.z;
    r9.xy = r10.xy;
  }
  r0.x = rcp(r1.z);
  r0.xyzw = r8.xyzw * r0.xxxx;
  r0.xyz = float3(0.0399999991,0.0399999991,0.0399999991) * r0.xyz;
  r0.xyz = log2(r0.xyz);
  r0.xyz = float3(0.333299994,0.333299994,0.333299994) * r0.xyz;
  r0.xyz = exp2(r0.xyz);
  r1.xy = float2(0.5,0.5) * v0.xy;
  r1.xy = frac(r1.xy);
  r1.x = r1.y * 2 + r1.x;
  r1.x = r1.x * 0.833333313 + -1;
  r1.x = 0.00240000011 * r1.x;
  r1.yzw = saturate(float3(10000,10000,10000) * r0.xyz);
  o0.xyz = r1.yzw * r1.xxx + r0.xyz;
  o0.w = r0.w;
  return;
}