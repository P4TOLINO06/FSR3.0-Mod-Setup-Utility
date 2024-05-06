// ---- FNV Hash 55e4b0f320918721

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:20 2023

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

cbuffer lighting_globals : register(b3)
{
  float4 gDirectionalLight : packoffset(c0);
  float4 gDirectionalColour : packoffset(c1);
  int gNumForwardLights : packoffset(c2);
  float4 gLightPositionAndInvDistSqr[8] : packoffset(c3);
  float4 gLightDirectionAndFalloffExponent[8] : packoffset(c11);
  float4 gLightColourAndCapsuleExtent[8] : packoffset(c19);
  float gLightConeScale[8] : packoffset(c27);
  float gLightConeOffset[8] : packoffset(c35);
  float4 gLightNaturalAmbient0 : packoffset(c43);
  float4 gLightNaturalAmbient1 : packoffset(c44);
  float4 gLightArtificialIntAmbient0 : packoffset(c45);
  float4 gLightArtificialIntAmbient1 : packoffset(c46);
  float4 gLightArtificialExtAmbient0 : packoffset(c47);
  float4 gLightArtificialExtAmbient1 : packoffset(c48);
  float4 gDirectionalAmbientColour : packoffset(c49);
  float4 globalFogParams[5] : packoffset(c50);
  float4 globalFogColor : packoffset(c55);
  float4 globalFogColorE : packoffset(c56);
  float4 globalFogColorN : packoffset(c57);
  float4 globalFogColorMoon : packoffset(c58);
  float4 gReflectionTweaks : packoffset(c59);
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
  float3 specMapIntMask : packoffset(c1);
  float bumpiness : packoffset(c1.w);
  float heightScale : packoffset(c2);
  float heightBias : packoffset(c2.y);
  float parallaxSelfShadowAmount : packoffset(c2.z);
  float wetnessMultiplier : packoffset(c2.w);
  float useTessellation : packoffset(c3);
  float HardAlphaBlend : packoffset(c3.y);
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
SamplerState heightSampler_s : register(s3);
SamplerState BumpSampler_s : register(s4);
SamplerState SpecSampler_s : register(s5);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> heightSampler : register(t3);
Texture2D<float4> BumpSampler : register(t4);
Texture2D<float4> SpecSampler : register(t5);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : COLOR0,
  float4 v2 : COLOR1,
  float4 v3 : TEXCOORD0,
  float4 v4 : TEXCOORD1,
  float4 v5 : TEXCOORD3,
  float4 v6 : TEXCOORD4,
  float3 v7 : TEXCOORD5,
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
  const float4 icb[] = { { 1.000000, 0, 0, 0},
                              { 0, 1.000000, 0, 0},
                              { 0, 0, 1.000000, 0},
                              { 0, 0, 0, 1.000000} };
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = (uint2)v0.xy;
  r0.xy = (int2)r0.xy & int2(1,1);
  r0.y = (uint)r0.y << 1;
  r0.x = (int)r0.x + (int)r0.y;
  r0.x = dot(globalFade.xyzw, icb[r0.x+0].xyzw);
  r0.x = cmp(r0.x < 1);
  if (r0.x != 0) discard;
  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v3.xy).xyzw;
  r0.x = globalScalars.x * r0.w;
  r0.x = cmp(gAlphaRefVec0.x >= r0.x);
  if (r0.x != 0) discard;
  r0.x = cmp(POMFlags.x == 1.000000);
  if (r0.x == 0) {
    r0.y = saturate(v3.z);
    r0.y = 1 + -r0.y;
    r0.z = 1 + -v3.w;
    r0.z = max(0.100000001, r0.z);
    r0.z = min(1, r0.z);
    r1.x = dot(v6.xyz, v5.xyz);
    r1.y = dot(v7.xyz, v5.xyz);
    r1.z = dot(v4.xyz, v5.xyz);
    r0.w = dot(r1.xyz, r1.xyz);
    r0.w = rsqrt(r0.w);
    r1.xyz = r1.xyz * r0.www;
    r0.z = max(r1.z, r0.z);
    r0.w = dot(v5.xyz, v5.xyz);
    r0.w = rsqrt(r0.w);
    r2.xyz = v5.xyz * r0.www;
    r0.w = dot(v4.xyz, v4.xyz);
    r0.w = rsqrt(r0.w);
    r3.xyz = v4.xyz * r0.www;
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
      r1.xy = ddx(v3.xy);
      r2.xy = ddy(v3.xy);
      r3.xyzw = heightSampler.SampleGrad(heightSampler_s, v3.xy, r1.xyxx, r2.xyxx).xyzw;
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
          r5.xy = v3.xy + r3.xy;
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
    r0.xy = v3.xy + r0.xy;
    r0.zw = r0.xy;
    r1.xy = r0.xy;
  } else {
    r1.xy = v3.xy;
    r0.xyzw = v3.xyxy;
  }
  r2.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, r0.zw).xyzw;
  r3.xyzw = BumpSampler.Sample(BumpSampler_s, r0.xy).xyzw;
  r0.xy = r3.xy * float2(2,2) + float2(-1,-1);
  r1.z = dot(r0.xy, r0.xy);
  r1.z = 1 + -r1.z;
  r1.z = sqrt(abs(r1.z));
  r1.w = max(0.00100000005, bumpiness);
  r0.xy = r1.ww * r0.xy;
  r3.xyz = v7.xyz * r0.yyy;
  r3.xyz = r0.xxx * v6.xyz + r3.xyz;
  r3.xyz = r1.zzz * v4.xyz + r3.xyz;
  r0.x = dot(r3.xyz, r3.xyz);
  r0.x = rsqrt(r0.x);
  r3.xyw = r3.xyz * r0.xxx;
  r1.xyzw = SpecSampler.Sample(SpecSampler_s, r1.xy).xyzw;
  r1.xy = r1.xy * r1.xy;
  r0.y = dot(r1.xyz, specMapIntMask.xyz);
  r1.x = specularIntensityMult * r0.y;
  r1.w = specularFalloffMult * r1.w;
  r4.x = dot(v6.xyz, gDirectionalLight.xyz);
  r4.y = dot(v7.xyz, gDirectionalLight.xyz);
  r4.z = dot(v4.xyz, gDirectionalLight.xyz);
  r4.w = 1 + -v3.z;
  r5.x = heightScale * globalHeightScale;
  r4.xy = r5.xx * r4.xy;
  r4.xy = r4.xy * r4.ww;
  r4.xy = r4.xy / r4.zz;
  r5.xyzw = heightSampler.Sample(heightSampler_s, r0.zw).xyzw;
  r6.xyzw = r4.xyxy * float4(0.879999995,0.879999995,0.769999981,0.769999981) + r0.zwzw;
  r7.xyzw = heightSampler.Sample(heightSampler_s, r6.xy).xyzw;
  r4.z = r7.x + -r5.x;
  r6.xyzw = heightSampler.Sample(heightSampler_s, r6.zw).xyzw;
  r4.w = r6.x + -r5.x;
  r4.zw = float2(-0.879999995,-0.769999981) + r4.zw;
  r4.w = r4.w + r4.w;
  r6.xyzw = r4.xyxy * float4(0.660000026,0.660000026,0.550000012,0.550000012) + r0.zwzw;
  r7.xyzw = heightSampler.Sample(heightSampler_s, r6.xy).xyzw;
  r5.y = r7.x + -r5.x;
  r5.y = -0.660000026 + r5.y;
  r6.xyzw = heightSampler.Sample(heightSampler_s, r6.zw).xyzw;
  r5.z = r6.x + -r5.x;
  r5.z = -0.550000012 + r5.z;
  r6.xyzw = r4.xyxy * float4(0.439999998,0.439999998,0.330000013,0.330000013) + r0.zwzw;
  r7.xyzw = heightSampler.Sample(heightSampler_s, r6.xy).xyzw;
  r5.w = r7.x + -r5.x;
  r5.w = -0.439999998 + r5.w;
  r5.yzw = float3(4,6,8) * r5.yzw;
  r6.xyzw = heightSampler.Sample(heightSampler_s, r6.zw).xyzw;
  r6.x = r6.x + -r5.x;
  r6.x = -0.330000013 + r6.x;
  r6.x = 10 * r6.x;
  r0.zw = r4.xy * float2(0.219999999,0.219999999) + r0.zw;
  r7.xyzw = heightSampler.Sample(heightSampler_s, r0.zw).xyzw;
  r0.z = r7.x + -r5.x;
  r0.z = -0.219999999 + r0.z;
  r0.z = 12 * r0.z;
  r0.w = max(r4.z, r4.w);
  r0.w = max(r0.w, r5.y);
  r0.w = max(r0.w, r5.z);
  r0.w = max(r0.w, r5.w);
  r0.w = max(r0.w, r6.x);
  r0.z = saturate(max(r0.w, r0.z));
  o2.w = -r0.z * parallaxSelfShadowAmount + 1;
  r0.z = saturate(v4.z * 128 + -127);
  r2.xyz = v2.xyz * r2.xyz;
  r0.w = v1.w * r2.w;
  r4.yz = globalScalars.zy * v1.xy;
  o0.w = globalScalars.x * r0.w;
  o1.xyz = r3.xyw * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.w = -0.200000003 + wetnessMultiplier;
  r0.w = saturate(10 * r0.w);
  o1.w = r0.z * r0.w;
  r1.y = 0.001953125 * r1.w;
  r4.x = v1.x * globalScalars.z + gLightArtificialIntAmbient0.w;
  r0.zw = float2(0.5,0.5) * r4.xz;
  o3.xy = sqrt(r0.zw);
  r0.x = r3.z * r0.x + -0.349999994;
  r0.x = saturate(1.53846157 * r0.x);
  r0.x = gDynamicBakesAndWetness.z * r0.x;
  r0.z = 1 + -globalScalars2.z;
  r0.x = r0.x * r0.z;
  r0.x = r0.x * r4.y;
  r0.z = -r1.x * 0.5 + 1;
  r0.z = r0.x * r0.z;
  r0.x = wetnessMultiplier * r0.x;
  r0.z = r0.z * -0.5 + 1;
  o0.xyz = r2.xyz * r0.zzz;
  r0.y = saturate(r0.y * specularIntensityMult + 0.400000006);
  r2.xy = float2(0.5,0.48828125) * r0.yy;
  r1.z = specularFresnel;
  r2.z = 0.970000029;
  r0.yzw = r2.xyz + -r1.xyz;
  r0.yzw = max(float3(0,0,0), r0.yzw);
  r0.xyz = r0.yzw * r0.xxx + r1.xyz;
  o2.xy = sqrt(r0.xy);
  o2.z = r0.z;
  o3.zw = float2(0,1.00188386);
  return;
}