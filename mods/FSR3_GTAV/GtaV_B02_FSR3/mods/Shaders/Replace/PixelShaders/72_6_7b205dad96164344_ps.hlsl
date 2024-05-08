// ---- FNV Hash 7b205dad96164344

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:21 2023

cbuffer misc_globals : register(b2)
{
  float4 globalFade : packoffset(c0);
  float globalHeightScale : packoffset(c1);
  float globalShaderQuality : packoffset(c1.y);
  float globalReuseMe00001 : packoffset(c1.z);
  float globalReuseMe00002 : packoffset(c1.w);
  float4 POMFlags : packoffset(c2);
  float4 g_Rage_Tessellation_CameraPosition : packoffset(c3);
  float4 g_Rage_Tessellation_CameraZAxis : packoffset(c4);
  float4 g_Rage_Tessellation_ScreenSpaceErrorParams : packoffset(c5);
  float4 g_Rage_Tessellation_LinearScale : packoffset(c6);
  float4 g_Rage_Tessellation_Frustum[4] : packoffset(c7);
  float4 g_Rage_Tessellation_Epsilons : packoffset(c11);
  float4 globalScalars : packoffset(c12);
  float4 globalScalars2 : packoffset(c13);
  float4 globalScalars3 : packoffset(c14);
  float4 globalScreenSize : packoffset(c15);
  uint4 gTargetAAParams : packoffset(c16);
  float4 colorize : packoffset(c17);
  float4 gGlobalParticleShadowBias : packoffset(c18);
  float gGlobalParticleDofAlphaScale : packoffset(c19);
  float gGlobalFogIntensity : packoffset(c19.y);
  float4 gPlayerLFootPos : packoffset(c20);
  float4 gPlayerRFootPos : packoffset(c21);
}

cbuffer more_stuff : register(b5)
{
  float4 gEntitySelectColor[2] : packoffset(c0);
  float4 gAmbientOcclusionEffect : packoffset(c2);
  float4 gDynamicBakesAndWetness : packoffset(c3);
  float4 gAlphaRefVec0 : packoffset(c4);
  float4 gAlphaRefVec1 : packoffset(c5);
  float gAlphaTestRef : packoffset(c6);
  bool gTreesUseDiscard : packoffset(c6.y);
  float gReflectionMipCount : packoffset(c6.z);
  float gTransparencyAASamples : packoffset(c6.w);
  bool gUseFogRay : packoffset(c7);
}

cbuffer megashader_locals : register(b12)
{
  float specularFresnel : packoffset(c0);
  float specularFalloffMult : packoffset(c0.y);
  float specularIntensityMult : packoffset(c0.z);
  float bumpiness : packoffset(c0.w);
  float heightScale : packoffset(c1);
  float heightBias : packoffset(c1.y);
  float parallaxSelfShadowAmount : packoffset(c1.z);
  float wetnessMultiplier : packoffset(c1.w);
  float useTessellation : packoffset(c2);
  float HardAlphaBlend : packoffset(c2.y);
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

SamplerState DiffuseSampler_s : register(s0);
SamplerState heightSampler_s : register(s2);
SamplerState BumpSampler_s : register(s3);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> heightSampler : register(t2);
Texture2D<float4> BumpSampler : register(t3);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD0,
  float4 v3 : TEXCOORD1,
  float4 v4 : TEXCOORD3,
  float4 v5 : TEXCOORD4,
  float3 v6 : TEXCOORD5,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float4 o1 : SV_Target1,
  out float4 o2 : SV_Target2,
  out float4 o3 : SV_Target3,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cmp(POMFlags.x == 1.000000);
  if (r0.x == 0) {
    r0.y = saturate(v2.z);
    r0.y = 1 + -r0.y;
    r0.z = 1 + -v2.w;
    r0.z = max(0.100000001, r0.z);
    r0.z = min(1, r0.z);
    r1.x = dot(v5.xyz, v4.xyz);
    r1.y = dot(v6.xyz, v4.xyz);
    r1.z = dot(v3.xyz, v4.xyz);
    r0.w = dot(r1.xyz, r1.xyz);
    r0.w = rsqrt(r0.w);
    r1.xyz = r1.xyz * r0.www;
    r0.z = max(r1.z, r0.z);
    r0.w = dot(v4.xyz, v4.xyz);
    r0.w = rsqrt(r0.w);
    r2.xyz = v4.xyz * r0.www;
    r0.w = dot(v3.xyz, v3.xyz);
    r0.w = rsqrt(r0.w);
    r3.xyz = v3.xyz * r0.www;
    r0.w = dot(r2.xyz, r3.xyz);
    r1.z = 4 * abs(r0.w);
    r0.y = globalHeightScale * r0.y;
    r2.xy = abs(r0.ww) * float2(-24,-24) + float2(26,27);
    r2.x = saturate(r2.x);
    r0.y = r2.x * r0.y;
    r0.w = min(1, r1.z);
    r0.y = r0.y * r0.w;
    r1.zw = -r1.xy / r0.zz;
    r1.zw = heightScale * r1.zw;
    r1.zw = r1.zw * r0.yy;
    r0.zw = r1.xy / r0.zz;
    r0.zw = heightBias * r0.zw;
    r0.yz = r0.zw * r0.yy;
    r0.w = (int)r2.y;
    r1.x = cmp((int)r0.w == 0);
    r0.x = (int)r0.x | (int)r1.x;
    if (r0.x == 0) {
      r0.x = trunc(r2.y);
      r0.x = 1 / r0.x;
      r1.xy = ddx(v2.xy);
      r2.xy = ddy(v2.xy);
      r3.xyzw = heightSampler.SampleGrad(heightSampler_s, v2.xy, r1.xyxx, r2.xyxx).xyzw;
      r2.z = 9.99999997e-07 + r3.x;
      r3.xy = r0.yz;
      r2.w = 1;
      r3.z = 1;
      r3.w = r2.z;
      r4.x = r2.z;
      r4.y = 0;
      while (true) {
        r4.z = cmp((int)r4.y >= (int)r0.w);
        if (r4.z != 0) break;
        r4.z = cmp(r3.w < r2.w);
        if (r4.z != 0) {
          r4.z = r2.w + -r0.x;
          r3.xy = r1.zw * r0.xx + r3.xy;
          r5.xy = v2.xy + r3.xy;
          r5.xyzw = heightSampler.SampleGrad(heightSampler_s, r5.xy, r1.xyxx, r2.xyxx).xyzw;
          r3.z = r2.w;
          r4.x = r3.w;
          r2.w = r4.z;
          r3.w = r5.x;
        } else {
          r4.y = r0.w;
        }
        r4.y = (int)r4.y + 1;
      }
      r0.x = -r3.w + r2.w;
      r0.w = -r4.x + r3.z;
      r1.x = r0.w + -r0.x;
      r1.y = cmp(0 < r1.x);
      r0.x = r3.z * r0.x;
      r0.x = r2.w * r0.w + -r0.x;
      r0.x = r0.x / r1.x;
      r0.x = saturate(r1.y ? r0.x : r3.w);
    } else {
      r0.x = 0;
    }
    r0.x = 1 + -r0.x;
    r0.xy = r1.zw * r0.xx + r0.yz;
    r0.xy = v2.xy + r0.xy;
    r0.zw = r0.xy;
  } else {
    r0.xyzw = v2.xyxy;
  }
  r1.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, r0.zw).xyzw;
  r0.xyzw = BumpSampler.Sample(BumpSampler_s, r0.xy).xyzw;
  r0.xy = r0.xy * float2(2,2) + float2(-1,-1);
  r0.z = dot(r0.xy, r0.xy);
  r0.z = 1 + -r0.z;
  r0.z = sqrt(abs(r0.z));
  r0.w = max(0.00100000005, bumpiness);
  r0.xy = r0.xy * r0.ww;
  r2.xyz = v6.xyz * r0.yyy;
  r0.xyw = r0.xxx * v5.xyz + r2.xyz;
  r0.xyz = r0.zzz * v3.xyz + r0.xyw;
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r0.xyz * r0.www;
  r0.x = v1.w * r1.w;
  r0.y = globalScalars.z * v1.x;
  r0.x = globalScalars.x * r0.x;
  o1.xyz = r2.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.z = r0.z * r0.w + -0.349999994;
  r0.z = saturate(1.53846157 * r0.z);
  r0.z = gDynamicBakesAndWetness.z * r0.z;
  r0.w = 1 + -globalScalars2.z;
  r0.z = r0.z * r0.w;
  r0.y = r0.z * r0.y;
  r0.z = 0.001953125 * specularFalloffMult;
  r2.z = -r0.z;
  r0.w = -specularIntensityMult * 0.5 + 1;
  r0.w = r0.y * r0.w;
  r0.y = wetnessMultiplier * r0.y;
  r0.w = r0.w * -0.5 + 1;
  o0.xyz = r1.xyz * r0.www;
  r0.w = saturate(0.699999988 + specularIntensityMult);
  r1.xy = float2(0.5,0.48828125) * r0.ww;
  r2.yw = -float2(specularIntensityMult, specularFresnel);
  r1.z = 0.970000029;
  r1.xyz = r2.yzw + r1.xyz;
  r1.xyz = max(float3(0,0,0), r1.xyz);
  r2.xz = r1.xz * r0.yy + float2(specularIntensityMult, specularFresnel);
  r2.y = r1.y * r0.y + r0.z;
  o2.xy = sqrt(r2.xy);
  o0.w = r0.x;
  o1.w = r0.x;
  o2.z = r2.z;
  o2.w = r0.x;
  o3.xyzw = float4(0,0,0,1);
  return;
}