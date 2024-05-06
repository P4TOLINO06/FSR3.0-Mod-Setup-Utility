// ---- FNV Hash 6b428c3af5a67b61

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

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
  float reflectivePower : packoffset(c1.w);
  float useTessellation : packoffset(c2);
  float HardAlphaBlend : packoffset(c2.y);
  float4 gMirrorBounds : packoffset(c3);
  float4 gMirrorDebugParams : packoffset(c4);
}

SamplerState DiffuseSampler_s : register(s0);
SamplerState ReflectionSampler_s : register(s1);
SamplerState SpecSampler_s : register(s2);
SamplerState FogRaySampler_s : register(s11);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> ReflectionSampler : register(t1);
Texture2D<float4> SpecSampler : register(t2);
Texture2D<float4> FogRaySampler : register(t11);


// 3Dmigoto declarations
#define cmp -


void main(
  linear centroid float4 v0 : COLOR0,
  float3 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD3,
  float4 v4 : TEXCOORD6,
  float4 v5 : TEXCOORD7,
  float4 v6 : SV_Position0,
  float4 v7 : SV_ClipDistance0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float o1 : SV_Target1,
  out float o2 : SV_Target2,
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

  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.xy).xyzw;
  r1.x = dot(v2.xyz, v2.xyz);
  r1.x = rsqrt(r1.x);
  r1.yzw = v2.xyz * r1.xxx;
  r2.xyzw = SpecSampler.Sample(SpecSampler_s, v1.xy).xyzw;
  r2.xy = r2.xy * r2.xy;
  r2.x = dot(r2.xyz, specMapIntMask.xyz);
  r2.x = saturate(specularIntensityMult * r2.x);
  r2.yz = v5.xy / v5.ww;
  r2.yz = gMirrorBounds.zw * r2.yz + gMirrorBounds.xy;
  r3.xyzw = ReflectionSampler.Sample(ReflectionSampler_s, r2.yz).xyzw;
  r0.w = v0.w * r0.w;
  r2.yz = globalScalars.zy * v0.xy;
  r0.xyz = r0.xyz * r0.xyz;
  r2.yz = r2.yz * r2.yz;
  r2.x = 1 + -r2.x;
  r1.x = v2.z * r1.x + gLightNaturalAmbient0.w;
  r1.x = gLightNaturalAmbient1.w * r1.x;
  r1.x = max(0, r1.x);
  r4.xyz = gLightArtificialExtAmbient0.xyz * r1.xxx + gLightArtificialExtAmbient1.xyz;
  r2.w = 1 + -globalScalars2.z;
  r5.xyz = gLightArtificialIntAmbient0.xyz * r1.xxx + gLightArtificialIntAmbient1.xyz;
  r5.xyz = globalScalars2.zzz * r5.xyz;
  r4.xyz = r4.xyz * r2.www + r5.xyz;
  r4.xyz = r4.xyz * r2.zzz;
  r5.xyz = gLightNaturalAmbient0.xyz * r1.xxx + gLightNaturalAmbient1.xyz;
  r6.x = gLightArtificialIntAmbient1.w;
  r6.y = gLightArtificialExtAmbient0.w;
  r6.z = gLightArtificialExtAmbient1.w;
  r1.x = saturate(dot(r6.xyz, r1.yzw));
  r1.xyz = gDirectionalAmbientColour.xyz * r1.xxx + r5.xyz;
  r1.xyz = r1.xyz * r2.yyy + r4.xyz;
  r1.xyz = r1.xyz * r2.xxx;
  r1.w = 1 + -r2.x;
  r2.xyz = r3.xyz * r1.www;
  r0.xyz = r1.xyz * r0.xyz + r2.xyz;
  r0.w = globalScalars.x * r0.w;
  if (gUseFogRay != 0) {
    r1.xyz = -gViewInverse._m30_m31_m32 + v4.xyz;
    r1.w = dot(r1.xyz, r1.xyz);
    r2.x = sqrt(r1.w);
    r2.y = -globalFogParams[0].x + r2.x;
    r2.y = max(0, r2.y);
    r2.x = r2.y / r2.x;
    r2.x = r2.x * r1.z;
    r2.z = globalFogParams[2].z * r2.x;
    r2.x = cmp(0.00999999978 < abs(r2.x));
    r2.w = -1.44269502 * r2.z;
    r2.w = exp2(r2.w);
    r2.w = 1 + -r2.w;
    r2.z = r2.w / r2.z;
    r2.x = r2.x ? r2.z : 1;
    r2.z = globalFogParams[1].w * r2.y;
    r2.x = r2.z * r2.x;
    r2.x = min(1, r2.x);
    r2.x = 1.44269502 * r2.x;
    r2.x = exp2(r2.x);
    r2.x = min(1, r2.x);
    r2.x = 1 + -r2.x;
    r2.z = globalFogParams[2].y * r2.x;
    r1.w = rsqrt(r1.w);
    r1.xyz = r1.xyz * r1.www;
    r1.w = saturate(dot(r1.xyz, globalFogParams[4].xyz));
    r1.w = log2(r1.w);
    r1.w = globalFogParams[4].w * r1.w;
    r1.w = exp2(r1.w);
    r1.x = saturate(dot(r1.xyz, globalFogParams[3].xyz));
    r1.x = log2(r1.x);
    r1.x = globalFogParams[3].w * r1.x;
    r1.x = exp2(r1.x);
    r1.y = -r2.x * globalFogParams[2].y + 1;
    r1.z = -globalFogParams[2].x + r2.y;
    r1.z = max(0, r1.z);
    r1.yz = globalFogParams[1].yx * r1.yz;
    r1.z = 1.44269502 * r1.z;
    r1.z = exp2(r1.z);
    r1.z = 1 + -r1.z;
    r1.z = saturate(r1.y * r1.z + r2.z);
    r2.x = -globalFogParams[1].z * r2.y;
    r2.x = 1.44269502 * r2.x;
    r2.x = exp2(r2.x);
    r2.x = 1 + -r2.x;
    r2.yzw = globalFogColorMoon.xyz + -globalFogColorE.xyz;
    r2.yzw = r1.www * r2.yzw + globalFogColorE.xyz;
    r3.xyz = globalFogColor.xyz + -r2.yzw;
    r2.yzw = r1.xxx * r3.xyz + r2.yzw;
    r2.yzw = -globalFogColorN.xyz + r2.yzw;
    r2.xyz = r2.xxx * r2.yzw + globalFogColorN.xyz;
    r3.x = globalFogColor.w;
    r3.y = globalFogColorE.w;
    r3.z = globalFogColorN.w;
    r3.xyz = r3.xyz + -r2.xyz;
    r1.xyw = r1.yyy * r3.xyz + r2.xyz;
    r2.x = cmp(0 < gGlobalFogIntensity);
    if (r2.x != 0) {
      r2.xy = globalScreenSize.zw * v6.xy;
      r2.xyzw = FogRaySampler.Sample(FogRaySampler_s, r2.xy).xyzw;
      r2.x = -1 + r2.x;
      r2.x = saturate(gGlobalFogIntensity * r2.x + 1);
    } else {
      r2.x = 1;
    }
    r1.xyw = r1.xyw * r2.xxx + -r0.xyz;
    r1.xyz = r1.zzz * r1.xyw + r0.xyz;
  } else {
    r2.xyz = -gViewInverse._m30_m31_m32 + v4.xyz;
    r1.w = dot(r2.xyz, r2.xyz);
    r2.w = sqrt(r1.w);
    r3.x = -globalFogParams[0].x + r2.w;
    r3.x = max(0, r3.x);
    r2.w = r3.x / r2.w;
    r2.w = r2.z * r2.w;
    r3.y = globalFogParams[2].z * r2.w;
    r2.w = cmp(0.00999999978 < abs(r2.w));
    r3.z = -1.44269502 * r3.y;
    r3.z = exp2(r3.z);
    r3.z = 1 + -r3.z;
    r3.y = r3.z / r3.y;
    r2.w = r2.w ? r3.y : 1;
    r3.y = globalFogParams[1].w * r3.x;
    r2.w = r3.y * r2.w;
    r2.w = min(1, r2.w);
    r2.w = 1.44269502 * r2.w;
    r2.w = exp2(r2.w);
    r2.w = min(1, r2.w);
    r2.w = 1 + -r2.w;
    r3.y = globalFogParams[2].y * r2.w;
    r1.w = rsqrt(r1.w);
    r2.xyz = r2.xyz * r1.www;
    r1.w = saturate(dot(r2.xyz, globalFogParams[4].xyz));
    r1.w = log2(r1.w);
    r1.w = globalFogParams[4].w * r1.w;
    r1.w = exp2(r1.w);
    r2.x = saturate(dot(r2.xyz, globalFogParams[3].xyz));
    r2.x = log2(r2.x);
    r2.x = globalFogParams[3].w * r2.x;
    r2.x = exp2(r2.x);
    r2.y = -r2.w * globalFogParams[2].y + 1;
    r2.z = -globalFogParams[2].x + r3.x;
    r2.z = max(0, r2.z);
    r2.yz = globalFogParams[1].yx * r2.yz;
    r2.z = 1.44269502 * r2.z;
    r2.z = exp2(r2.z);
    r2.z = 1 + -r2.z;
    r2.z = saturate(r2.y * r2.z + r3.y);
    r2.w = -globalFogParams[1].z * r3.x;
    r2.w = 1.44269502 * r2.w;
    r2.w = exp2(r2.w);
    r2.w = 1 + -r2.w;
    r3.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
    r3.xyz = r1.www * r3.xyz + globalFogColorE.xyz;
    r4.xyz = globalFogColor.xyz + -r3.xyz;
    r3.xyz = r2.xxx * r4.xyz + r3.xyz;
    r3.xyz = -globalFogColorN.xyz + r3.xyz;
    r3.xyz = r2.www * r3.xyz + globalFogColorN.xyz;
    r4.x = globalFogColor.w;
    r4.y = globalFogColorE.w;
    r4.z = globalFogColorN.w;
    r4.xyz = r4.xyz + -r3.xyz;
    r2.xyw = r2.yyy * r4.xyz + r3.xyz;
    r2.xyw = r2.xyw + -r0.xyz;
    r1.xyz = r2.zzz * r2.xyw + r0.xyz;
  }
  o0.xyz = globalScalars3.zzz * r1.xyz;
  r0.x = cmp(0.300000012 < r0.w);
  r0.x = r0.x ? 1.000000 : 0;
  o1.x = v1.z * r0.x;
  o0.w = r0.w;
  o2.x = r0.x;
  return;
}