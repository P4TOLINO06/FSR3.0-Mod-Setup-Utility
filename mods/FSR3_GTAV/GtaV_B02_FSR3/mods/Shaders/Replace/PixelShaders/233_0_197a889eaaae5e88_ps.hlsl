// ---- FNV Hash 197a889eaaae5e88

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
Texture2D<float4> Texture3 : register(t3);
Texture2D<float4> Texture4 : register(t4);
Texture2D<float4> Texture5 : register(t5);
Texture2D<float4> Texture6 : register(t6);


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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.y = ScreenSize.y * ScreenSize.z;
  r0.zw = SSAOsplitcount * v1.xy;
  r1.xy = floor(r0.zw);
  r0.x = ScreenSize.y;
  r0.zw = r1.xy * r0.xy + r0.zw;
  r0.zw = r0.xy * float2(0.5,0.5) + r0.zw;
  r2.xy = frac(r0.zw);
  r3.xyzw = Texture0.SampleLevel(Sampler8_s, r2.xy, 0).xyzw;
  r0.z = cmp(0.99999702 < r3.x);
  if (r0.z != 0) discard;
  r0.z = 0.25 * Parameters01.x;
  r0.w = 1 / SSAOsplitcount;
  r1.zw = r2.xy / r0.xy;
  r0.xy = SSAOsplitcount * r0.xy;
  r1.xy = r0.xy * float2(2,2) + r1.xy;
  r3.yz = float2(1,1) + r1.xy;
  r0.xy = -r0.xy * float2(4,4) + r3.yz;
  r1.xy = r1.xy * r0.ww;
  r0.xy = r0.xy * r0.ww;
  r2.w = 1 + -r3.x;
  r2.w = max(1.00000002e-16, r2.w);
  r3.z = 1 / r2.w;
  r4.xyzw = Texture1.SampleLevel(Sampler8_s, r2.xy, 0).xyzw;
  r5.xy = float2(0.75,4) * ScreenSize.yy;
  r6.x = ScreenSize.z * r5.x;
  r7.xyzw = Texture5.SampleLevel(Sampler8_s, r2.xy, 0).xyzw;
  r7.xyzw = float4(-0.600000024,-0.600000024,-0.600000024,-0.600000024) + r7.xyzw;
  r7.xyzw = saturate(float4(3,3,3,3) * r7.xyzw);
  r6.y = ScreenSize.y;
  r8.xyzw = r6.yxyx * float4(-0.75,-1,0.75,-1) + r2.xyxy;
  r9.xyzw = Texture1.SampleLevel(Sampler9_s, r8.xy, 0).xyzw;
  r4.xyz = r9.xyz * r7.xxx + r4.xyz;
  r8.xyzw = Texture1.SampleLevel(Sampler9_s, r8.zw, 0).xyzw;
  r4.xyz = r8.xyz * r7.yyy + r4.xyz;
  r5.xz = r6.yx * float2(-0.75,1) + r2.xy;
  r8.xyzw = Texture1.SampleLevel(Sampler9_s, r5.xz, 0).xyzw;
  r4.xyz = r8.xyz * r7.zzz + r4.xyz;
  r6.z = 0.75 * ScreenSize.y;
  r5.xz = r6.zx + r2.xy;
  r6.xyzw = Texture1.SampleLevel(Sampler9_s, r5.xz, 0).xyzw;
  r4.xyz = r6.xyz * r7.www + r4.xyz;
  r2.w = dot(r7.xyzw, float4(1,1,1,1));
  r2.w = 1 + r2.w;
  r4.xyz = r4.xyz / r2.www;
  r4.xyz = r4.xyz * float3(2,2,2) + float3(-1,-1,-1);
  r6.x = dot(r4.xyz, Matrix04[0].xyz);
  r6.y = dot(r4.xyz, Matrix04[1].xyz);
  r6.z = dot(r4.xyz, Matrix04[2].xyz);
  r2.w = dot(r6.xyz, r6.xyz);
  r2.w = rsqrt(r2.w);
  r4.xyz = r6.xyz * r2.www;
  r6.xy = r2.xy * float2(2,2) + float2(-1,-1);
  r6.z = ScreenSize.w * r6.y;
  r3.xy = r6.xz * r3.zz;
  r2.w = r3.z * r3.z;
  r2.w = r2.w * 9.99999975e-05 + 1;
  r2.w = 1 / r2.w;
  r2.w = r2.w * 0.899999976 + 0.100000001;
  r3.w = r2.w * r2.w;
  r3.w = 2.49999994e-06 * r3.w;
  r3.w = r3.w / r0.z;
  r1.zw = float2(0.00390625,0.00390625) * r1.zw;
  r1.zw = frac(r1.zw);
  r6.xyzw = Texture6.SampleGrad(Sampler8_s, r1.zw, float4(0,0,0,0), float4(0,0,0,0)).xyzw;
  r1.zw = float2(1.04719579,0.0299999993) * r6.xy;
  sincos(r1.z, r5.x, r6.x);
  r1.z = r6.y * 0.0833330005 + 0.0833330005;
  r1.z = 0.333000004 * r1.z;
  r0.z = r2.w * r0.z;
  r2.w = r1.z * r0.z;
  r1.w = r1.w * r0.z + r5.y;
  r4.xyz = float3(1,-1,-1) * r4.xyz;
  r7.xyzw = float4(0,0,0,0);
  r4.w = 0;
  while (true) {
    r5.y = cmp((int)r4.w >= 2);
    if (r5.y != 0) break;
    r8.xyzw = r7.yzwx;
    r9.x = r6.x;
    r9.y = r5.x;
    r5.y = 0;
    while (true) {
      r5.z = cmp((int)r5.y >= 6);
      if (r5.z != 0) break;
      r10.x = dot(r9.xy, float2(0.5,-0.866020024));
      r10.z = dot(r9.yx, float2(0.5,0.866020024));
      r10.y = ScreenSize.z * r10.z;
      r6.yzw = r8.xyz;
      r5.z = r8.w;
      r5.w = r2.w;
      r11.x = r1.w;
      r9.z = 0;
      while (true) {
        r9.w = cmp((int)r9.z >= 12);
        if (r9.w != 0) break;
        r12.xy = r11.xx * r10.xy;
        r12.z = r11.x;
        r2.z = r5.w;
        r11.xyz = r12.zxy + r2.zxy;
        r5.w = r1.z * r0.z + r5.w;
        r12.xy = r12.xy * r0.ww + v1.xy;
        r12.xy = max(r12.xy, r1.xy);
        r12.xy = min(r12.xy, r0.xy);
        r13.xyzw = Texture3.SampleLevel(Sampler8_s, r12.xy, 0).yzxw;
        r14.xy = r11.yz * float2(2,2) + float2(-1,-1);
        r14.z = ScreenSize.w * r14.y;
        r13.xy = r14.xz * r13.zz;
        r11.yzw = r13.xyz + -r3.xyz;
        r2.z = dot(r11.yzw, r4.xyz);
        r9.w = dot(r11.yzw, r11.yzw);
        r10.w = rsqrt(r9.w);
        r2.z = r10.w * r2.z;
        r2.z = saturate(r2.z * 1.10000002 + -0.100000001);
        r12.z = cmp(0 < r2.z);
        if (r12.z != 0) {
          r9.w = r9.w * r9.w;
          r9.w = r9.w * r3.w + 1;
          r9.w = 1 / r9.w;
          r5.z = r2.z * r9.w + r5.z;
          r13.xyzw = Texture4.SampleLevel(Sampler8_s, r12.xy, 0).xyzw;
          r12.xyzw = Texture2.SampleLevel(Sampler8_s, r12.xy, 0).xyzw;
          r13.xyz = r13.xyz * float3(2,2,2) + float3(-1,-1,-1);
          r11.y = dot(-r13.xyz, r11.yzw);
          r10.w = r11.y * r10.w;
          r2.z = r10.w * r2.z;
          r2.z = saturate(8 * r2.z);
          r2.z = r2.z * r9.w;
          r6.yzw = r2.zzz * r12.xyz + r6.yzw;
        }
        r9.z = (int)r9.z + 1;
      }
      r8.xyz = r6.yzw;
      r8.w = r5.z;
      r5.y = (int)r5.y + 1;
      r9.xy = r10.xz;
    }
    r7.xyzw = r8.wxyz;
    r4.w = (int)r4.w + 1;
  }
  r0.xyzw = float4(0.0069444445,0.000277777785,0.000277777785,0.000277777785) * r7.xyzw;
  r0.x = sqrt(r0.x);
  r0.x = saturate(-r0.x * Parameters01.y + 1);
  r0.x = r0.x * r0.x;
  o0.w = r0.x * r0.x;
  r0.xyz = log2(r0.yzw);
  r0.xyz = float3(0.333299994,0.333299994,0.333299994) * r0.xyz;
  r0.xyz = exp2(r0.xyz);
  r1.xy = float2(0.5,0.5) * v0.xy;
  r1.xy = frac(r1.xy);
  r0.w = r1.y * 2 + r1.x;
  r0.w = r0.w * 0.833333313 + -1;
  r0.w = 0.00240000011 * r0.w;
  r1.xyz = float3(10000,10000,10000) * r0.xyz;
  r1.xyz = min(float3(1,1,1), r1.xyz);
  o0.xyz = r1.xyz * r0.www + r0.xyz;
  return;
}