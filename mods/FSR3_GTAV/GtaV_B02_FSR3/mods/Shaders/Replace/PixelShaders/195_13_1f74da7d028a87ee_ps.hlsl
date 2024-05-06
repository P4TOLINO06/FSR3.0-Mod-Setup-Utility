// ---- FNV Hash 1f74da7d028a87ee

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

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

cbuffer vehiclecommonlocals : register(b11)
{
  float3 matDiffuseColor : packoffset(c0);
  float4 matDiffuseColor2 : packoffset(c1);
  float4 matDiffuseColorTint : packoffset(c2);
  float4 dirtLevelMod : packoffset(c3);
  float3 dirtColor : packoffset(c4);
  float3 specMapIntMask : packoffset(c5);
  float reflectivePower : packoffset(c5.w);
  float envEffThickness : packoffset(c6);
  float2 envEffScale : packoffset(c6.y);
  float envEffTexTileUV : packoffset(c6.w);
}

cbuffer csmshader : register(b6)
{
  float4 gCSMShaderVars_shared[12] : packoffset(c0);
  float4 gCSMDepthBias : packoffset(c12);
  float4 gCSMDepthSlopeBias : packoffset(c13);
  float4 gCSMResolution : packoffset(c14);
  float4 gCSMShadowParams : packoffset(c15);
  row_major float4x4 gLocalLightShadowData[8] : packoffset(c16);
  float4 gShadowTexParam : packoffset(c48);
}

SamplerState DiffuseSampler_s : register(s0);
SamplerState ReflectionSampler_s : register(s1);
SamplerState DirtSampler_s : register(s3);
SamplerState SpecSampler_s : register(s4);
SamplerState FogRaySampler_s : register(s11);
SamplerComparisonState gCSMShadowTextureSamp_s : register(s15);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> ReflectionSampler : register(t1);
Texture2D<float4> DirtSampler : register(t3);
Texture2D<float4> SpecSampler : register(t4);
Texture2D<float4> FogRaySampler : register(t11);
Texture2D<float4> gCSMShadowTexture : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  linear sample float4 v0 : TEXCOORD0,
  linear sample float4 v1 : TEXCOORD1,
  linear sample float4 v2 : TEXCOORD2,
  float4 v3 : TEXCOORD3,
  linear sample float4 v4 : TEXCOORD6,
  linear sample float4 v5 : TEXCOORD8,
  float4 v6 : SV_Position0,
  float4 v7 : SV_ClipDistance0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[4];
  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v0.xy).xyzw;
  r1.x = dot(v1.xyz, v1.xyz);
  r1.x = rsqrt(r1.x);
  r1.yzw = v1.xyz * r1.xxx;
  r2.xyzw = SpecSampler.Sample(SpecSampler_s, v0.xy).xyzw;
  r2.xy = r2.xy * r2.xy;
  r2.x = dot(r2.xyz, specMapIntMask.xyz);
  r3.xyz = float3(-1,-1,-1) + matDiffuseColorTint.xyz;
  r3.xyz = v4.www * r3.xyz + float3(1,1,1);
  r0.xyz = r3.xyz * r0.xyz;
  r0.w = saturate(matDiffuseColorTint.w * v4.w + r0.w);
  r0.xyz = matDiffuseColor.xyz * r0.xyz;
  r0.xyz = v4.xxx * r0.xyz;
  r2.yz = globalScalars.zy * v4.xx;
  r3.x = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r2.z = r3.x * r2.z;
  r2.x = v4.x * r2.x;
  r2.x = v1.w * r2.x;
  r3.xy = float2(1,2) + -dirtLevelMod.zz;
  r3.z = v4.z * r3.x;
  r3.yw = v0.zw * r3.yy;
  r4.xyzw = DirtSampler.Sample(DirtSampler_s, r3.yw).xyzw;
  r3.y = dirtLevelMod.z * gDynamicBakesAndWetness.z;
  r3.w = r4.z + -r4.x;
  r4.x = r3.y * r3.w + r4.x;
  r3.yw = dirtLevelMod.xx * r4.xy;
  r4.x = v4.z * r3.x + -1;
  r3.x = r3.x * r4.x + 1;
  r4.x = r3.y * r3.x;
  r5.xyz = dirtColor.xyz * dirtLevelMod.yyy + -r0.xyz;
  r0.xyz = r4.xxx * r5.xyz + r0.xyz;
  r3.z = dirtLevelMod.x * r3.z;
  r4.xyz = r4.zzz + -r0.xyz;
  r0.xyz = r3.zzz * r4.xyz + r0.xyz;
  r0.w = r3.y * r3.x + r0.w;
  r3.x = -r3.w * r3.x + 1;
  r2.x = saturate(r3.x * r2.x);
  r0.xyz = r0.xyz * r0.xyz;
  r3.xyz = gViewInverse._m30_m31_m32 + -v2.xyz;
  r3.w = dot(r3.xyz, r3.xyz);
  r3.w = rsqrt(r3.w);
  r4.xyz = r3.xyz * r3.www;
  r5.xyz = r3.xyz * r3.www + -gDirectionalLight.xyz;
  r4.w = dot(r5.xyz, r5.xyz);
  r4.w = rsqrt(r4.w);
  r5.xyz = r5.xyz * r4.www;
  r2.yz = r2.yz * r2.yz;
  r4.w = r2.w * 510 + -500;
  r4.w = max(0, r4.w);
  r2.w = r2.w * 510 + -r4.w;
  r4.w = 558 * r4.w;
  r2.w = r2.w * 3 + r4.w;
  r6.xyz = -gViewInverse._m30_m31_m32 + v2.xyz;
  r7.xyz = gCSMShaderVars_shared[1].xyz * r6.yyy;
  r6.xyw = r6.xxx * gCSMShaderVars_shared[0].xyz + r7.xyz;
  r6.xyz = r6.zzz * gCSMShaderVars_shared[2].xyz + r6.xyw;
  r7.xyz = r6.xyz * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
  x0[0].xyz = r7.xyz;
  r8.xyz = r6.xyz * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
  x0[1].xyz = r8.xyz;
  r9.xyz = r6.xyz * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
  x0[2].xyz = r9.xyz;
  r6.xyz = r6.xyz * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
  x0[3].xyz = r6.xyz;
  r4.w = -gCSMResolution.z * 1.5 + 1;
  r4.w = 0.5 * r4.w;
  r5.w = max(abs(r9.x), abs(r9.y));
  r5.w = cmp(r5.w < r4.w);
  r5.w = r5.w ? 2 : 3;
  r6.x = max(abs(r8.x), abs(r8.y));
  r6.x = cmp(r6.x < r4.w);
  r5.w = r6.x ? 1 : r5.w;
  r6.x = max(abs(r7.x), abs(r7.y));
  r4.w = cmp(r6.x < r4.w);
  r4.w = r4.w ? 0 : r5.w;
  r6.xyz = x0[r4.w+0].xyz;
  r4.w = (int)r4.w;
  r5.w = 0.5 + r4.w;
  r5.w = 0.25 * r5.w;
  r7.xyzw = cmp(float4(0,1,2,3) == r4.wwww);
  r7.xyzw = r7.xyzw ? float4(1,1,1,1) : 0;
  r4.w = dot(r7.xyzw, gCSMDepthBias.xyzw);
  r6.w = dot(r7.xyzw, gCSMDepthSlopeBias.xyzw);
  r7.x = 0.5 + r6.x;
  r7.y = r6.y * 0.25 + r5.w;
  r5.w = cmp(r4.w != 0.000000);
  r4.w = r6.z + -r4.w;
  r8.xyw = ddx(r7.xyy);
  r8.z = ddx(r4.w);
  r9.xyz = ddy(r7.yxy);
  r9.w = ddy(r4.w);
  r6.xy = r9.yw * r8.yw;
  r10.xy = r8.xz * r9.xz + -r6.xy;
  r6.x = 1 / r10.x;
  r6.y = r9.y * r8.z;
  r10.z = r8.x * r9.w + -r6.y;
  r6.xy = r10.yz * r6.xx;
  r6.xy = max(float2(0,0), r6.xy);
  r6.xy = min(float2(0.5,0.5), r6.xy);
  r4.w = -r6.w * r6.x + r4.w;
  r4.w = -r6.w * r6.y + r4.w;
  r4.w = r5.w ? r4.w : r6.z;
  r4.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r7.xy, r4.w).x;
  r5.w = dot(r1.yzw, -gDirectionalLight.xyz);
  r6.x = saturate(r5.w);
  r6.x = r6.x + -abs(r5.w);
  r5.w = r0.w * r6.x + abs(r5.w);
  r6.x = saturate(dot(r4.xyz, r1.yzw));
  r6.y = saturate(dot(r5.xyz, -gDirectionalLight.xyz));
  r6.xy = float2(1,1) + -r6.xy;
  r6.zw = r6.xy * r6.xy;
  r6.zw = r6.zw * r6.zw;
  r6.xy = r6.zw * r6.xy;
  r6.xy = r6.xy * float2(0.959999979,0.959999979) + float2(0.0399999991,0.0399999991);
  r6.zw = float2(2,9.99999994e-09) + r2.ww;
  r6.z = 0.125 * r6.z;
  r6.x = -r2.x * r6.x + 1;
  r5.x = dot(r1.yzw, r5.xyz);
  r5.x = saturate(9.99999994e-09 + r5.x);
  r5.x = log2(r5.x);
  r5.x = r6.w * r5.x;
  r5.x = exp2(r5.x);
  r5.xy = r6.yx * r5.xw;
  r5.x = r5.x * r6.z;
  r5.x = r5.x * r2.x;
  r5.x = r5.x * r5.w;
  r5.xyz = r0.xyz * r5.yyy + r5.xxx;
  r5.xyz = gDirectionalColour.xyz * r5.xyz;
  r5.w = cmp(0 >= gNumForwardLights);
  if (r5.w == 0) {
    r6.y = cmp(gLightColourAndCapsuleExtent[0].w == 0.000000);
    r7.xyz = gLightPositionAndInvDistSqr[0].xyz + -v2.xyz;
    r8.xyz = -gLightPositionAndInvDistSqr[0].xyz + v2.xyz;
    r7.w = dot(r8.xyz, gLightDirectionAndFalloffExponent[0].xyz);
    r8.x = 9.99999975e-05 + gLightColourAndCapsuleExtent[0].w;
    r7.w = saturate(r7.w / r8.x);
    r7.w = gLightColourAndCapsuleExtent[0].w * r7.w;
    r8.xyz = gLightDirectionAndFalloffExponent[0].xyz * r7.www + gLightPositionAndInvDistSqr[0].xyz;
    r8.xyz = -v2.xyz + r8.xyz;
    r7.xyz = r6.yyy ? r7.xyz : r8.xyz;
    r6.y = dot(r7.xyz, r7.xyz);
    r7.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r7.xyz;
    r7.w = dot(r7.xyz, r7.xyz);
    r7.w = rsqrt(r7.w);
    r7.xyz = r7.xyz * r7.www;
    r6.y = saturate(-r6.y * gLightPositionAndInvDistSqr[0].w + 1);
    r7.w = 1 + -gLightDirectionAndFalloffExponent[0].w;
    r7.w = r7.w * r6.y + gLightDirectionAndFalloffExponent[0].w;
    r6.y = r6.y / r7.w;
    r7.w = dot(r7.xyz, -gLightDirectionAndFalloffExponent[0].xyz);
    r7.w = saturate(r7.w * gLightConeScale[0] + gLightConeOffset[0]);
    r8.x = dot(r7.xyz, r1.yzw);
    r8.y = saturate(r8.x);
    r8.y = r8.y + -abs(r8.x);
    r8.x = r0.w * r8.y + abs(r8.x);
    r7.w = r8.x * r7.w;
    r8.x = r7.w * r6.y;
    r8.xyz = gLightColourAndCapsuleExtent[0].xyz * r8.xxx;
    r8.xyz = r8.xyz * r0.xyz;
    r7.xyz = r3.xyz * r3.www + r7.xyz;
    r8.w = dot(r7.xyz, r7.xyz);
    r8.w = rsqrt(r8.w);
    r7.xyz = r8.www * r7.xyz;
    r8.w = saturate(dot(r7.xyz, r4.xyz));
    r8.w = 1 + -r8.w;
    r9.x = r8.w * r8.w;
    r9.x = r9.x * r9.x;
    r8.w = r9.x * r8.w;
    r8.w = r8.w * 0.959999979 + 0.0399999991;
    r7.x = saturate(dot(r7.xyz, r1.yzw));
    r7.x = log2(r7.x);
    r7.x = r7.x * r6.w;
    r7.x = exp2(r7.x);
    r7.x = r8.w * r7.x;
    r7.x = r7.x * r7.w;
    r6.y = r7.x * r6.y;
    r6.y = r6.y * r6.z;
    r7.xyz = gLightColourAndCapsuleExtent[0].xyz * r6.yyy;
  } else {
    r8.xyz = float3(0,0,0);
    r7.xyz = float3(0,0,0);
  }
  r6.y = cmp(0 < gNumForwardLights);
  if (r6.y != 0) {
    r7.w = cmp(1 >= gNumForwardLights);
    r6.y = (int)r5.w | (int)r6.y;
    r5.w = r7.w ? r6.y : r5.w;
    if (r5.w == 0) {
      r6.y = cmp(gLightColourAndCapsuleExtent[1].w == 0.000000);
      r9.xyz = gLightPositionAndInvDistSqr[1].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[1].xyz + v2.xyz;
      r7.w = dot(r10.xyz, gLightDirectionAndFalloffExponent[1].xyz);
      r8.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[1].w;
      r7.w = saturate(r7.w / r8.w);
      r7.w = gLightColourAndCapsuleExtent[1].w * r7.w;
      r10.xyz = gLightDirectionAndFalloffExponent[1].xyz * r7.www + gLightPositionAndInvDistSqr[1].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r9.xyz = r6.yyy ? r9.xyz : r10.xyz;
      r6.y = dot(r9.xyz, r9.xyz);
      r9.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r9.xyz;
      r7.w = dot(r9.xyz, r9.xyz);
      r7.w = rsqrt(r7.w);
      r9.xyz = r9.xyz * r7.www;
      r6.y = saturate(-r6.y * gLightPositionAndInvDistSqr[1].w + 1);
      r7.w = 1 + -gLightDirectionAndFalloffExponent[1].w;
      r7.w = r7.w * r6.y + gLightDirectionAndFalloffExponent[1].w;
      r6.y = r6.y / r7.w;
      r7.w = dot(r9.xyz, -gLightDirectionAndFalloffExponent[1].xyz);
      r7.w = saturate(r7.w * gLightConeScale[1] + gLightConeOffset[1]);
      r8.w = dot(r9.xyz, r1.yzw);
      r9.w = saturate(r8.w);
      r9.w = r9.w + -abs(r8.w);
      r8.w = r0.w * r9.w + abs(r8.w);
      r7.w = r8.w * r7.w;
      r8.w = r7.w * r6.y;
      r10.xyz = gLightColourAndCapsuleExtent[1].xyz * r8.www;
      r8.xyz = r10.xyz * r0.xyz + r8.xyz;
      r9.xyz = r3.xyz * r3.www + r9.xyz;
      r8.w = dot(r9.xyz, r9.xyz);
      r8.w = rsqrt(r8.w);
      r9.xyz = r9.xyz * r8.www;
      r8.w = saturate(dot(r9.xyz, r4.xyz));
      r8.w = 1 + -r8.w;
      r9.w = r8.w * r8.w;
      r9.w = r9.w * r9.w;
      r8.w = r9.w * r8.w;
      r8.w = r8.w * 0.959999979 + 0.0399999991;
      r9.x = saturate(dot(r9.xyz, r1.yzw));
      r9.x = log2(r9.x);
      r9.x = r9.x * r6.w;
      r9.x = exp2(r9.x);
      r8.w = r9.x * r8.w;
      r7.w = r8.w * r7.w;
      r6.y = r7.w * r6.y;
      r6.y = r6.y * r6.z;
      r7.xyz = r6.yyy * gLightColourAndCapsuleExtent[1].xyz + r7.xyz;
    }
  } else {
    r5.w = -1;
  }
  if (r5.w == 0) {
    r6.y = cmp(2 >= gNumForwardLights);
    r5.w = (int)r5.w | (int)r6.y;
    if (r5.w == 0) {
      r6.y = cmp(gLightColourAndCapsuleExtent[2].w == 0.000000);
      r9.xyz = gLightPositionAndInvDistSqr[2].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[2].xyz + v2.xyz;
      r7.w = dot(r10.xyz, gLightDirectionAndFalloffExponent[2].xyz);
      r8.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[2].w;
      r7.w = saturate(r7.w / r8.w);
      r7.w = gLightColourAndCapsuleExtent[2].w * r7.w;
      r10.xyz = gLightDirectionAndFalloffExponent[2].xyz * r7.www + gLightPositionAndInvDistSqr[2].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r9.xyz = r6.yyy ? r9.xyz : r10.xyz;
      r6.y = dot(r9.xyz, r9.xyz);
      r9.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r9.xyz;
      r7.w = dot(r9.xyz, r9.xyz);
      r7.w = rsqrt(r7.w);
      r9.xyz = r9.xyz * r7.www;
      r6.y = saturate(-r6.y * gLightPositionAndInvDistSqr[2].w + 1);
      r7.w = 1 + -gLightDirectionAndFalloffExponent[2].w;
      r7.w = r7.w * r6.y + gLightDirectionAndFalloffExponent[2].w;
      r6.y = r6.y / r7.w;
      r7.w = dot(r9.xyz, -gLightDirectionAndFalloffExponent[2].xyz);
      r7.w = saturate(r7.w * gLightConeScale[2] + gLightConeOffset[2]);
      r8.w = dot(r9.xyz, r1.yzw);
      r9.w = saturate(r8.w);
      r9.w = r9.w + -abs(r8.w);
      r8.w = r0.w * r9.w + abs(r8.w);
      r7.w = r8.w * r7.w;
      r8.w = r7.w * r6.y;
      r10.xyz = gLightColourAndCapsuleExtent[2].xyz * r8.www;
      r8.xyz = r10.xyz * r0.xyz + r8.xyz;
      r9.xyz = r3.xyz * r3.www + r9.xyz;
      r8.w = dot(r9.xyz, r9.xyz);
      r8.w = rsqrt(r8.w);
      r9.xyz = r9.xyz * r8.www;
      r8.w = saturate(dot(r9.xyz, r4.xyz));
      r8.w = 1 + -r8.w;
      r9.w = r8.w * r8.w;
      r9.w = r9.w * r9.w;
      r8.w = r9.w * r8.w;
      r8.w = r8.w * 0.959999979 + 0.0399999991;
      r9.x = saturate(dot(r9.xyz, r1.yzw));
      r9.x = log2(r9.x);
      r9.x = r9.x * r6.w;
      r9.x = exp2(r9.x);
      r8.w = r9.x * r8.w;
      r7.w = r8.w * r7.w;
      r6.y = r7.w * r6.y;
      r6.y = r6.y * r6.z;
      r7.xyz = r6.yyy * gLightColourAndCapsuleExtent[2].xyz + r7.xyz;
    }
  } else {
    r5.w = -1;
  }
  if (r5.w == 0) {
    r6.y = cmp(3 >= gNumForwardLights);
    r5.w = (int)r5.w | (int)r6.y;
    if (r5.w == 0) {
      r6.y = cmp(gLightColourAndCapsuleExtent[3].w == 0.000000);
      r9.xyz = gLightPositionAndInvDistSqr[3].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[3].xyz + v2.xyz;
      r7.w = dot(r10.xyz, gLightDirectionAndFalloffExponent[3].xyz);
      r8.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[3].w;
      r7.w = saturate(r7.w / r8.w);
      r7.w = gLightColourAndCapsuleExtent[3].w * r7.w;
      r10.xyz = gLightDirectionAndFalloffExponent[3].xyz * r7.www + gLightPositionAndInvDistSqr[3].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r9.xyz = r6.yyy ? r9.xyz : r10.xyz;
      r6.y = dot(r9.xyz, r9.xyz);
      r9.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r9.xyz;
      r7.w = dot(r9.xyz, r9.xyz);
      r7.w = rsqrt(r7.w);
      r9.xyz = r9.xyz * r7.www;
      r6.y = saturate(-r6.y * gLightPositionAndInvDistSqr[3].w + 1);
      r7.w = 1 + -gLightDirectionAndFalloffExponent[3].w;
      r7.w = r7.w * r6.y + gLightDirectionAndFalloffExponent[3].w;
      r6.y = r6.y / r7.w;
      r7.w = dot(r9.xyz, -gLightDirectionAndFalloffExponent[3].xyz);
      r7.w = saturate(r7.w * gLightConeScale[3] + gLightConeOffset[3]);
      r8.w = dot(r9.xyz, r1.yzw);
      r9.w = saturate(r8.w);
      r9.w = r9.w + -abs(r8.w);
      r8.w = r0.w * r9.w + abs(r8.w);
      r7.w = r8.w * r7.w;
      r8.w = r7.w * r6.y;
      r10.xyz = gLightColourAndCapsuleExtent[3].xyz * r8.www;
      r8.xyz = r10.xyz * r0.xyz + r8.xyz;
      r9.xyz = r3.xyz * r3.www + r9.xyz;
      r8.w = dot(r9.xyz, r9.xyz);
      r8.w = rsqrt(r8.w);
      r9.xyz = r9.xyz * r8.www;
      r8.w = saturate(dot(r9.xyz, r4.xyz));
      r8.w = 1 + -r8.w;
      r9.w = r8.w * r8.w;
      r9.w = r9.w * r9.w;
      r8.w = r9.w * r8.w;
      r8.w = r8.w * 0.959999979 + 0.0399999991;
      r9.x = saturate(dot(r9.xyz, r1.yzw));
      r9.x = log2(r9.x);
      r9.x = r9.x * r6.w;
      r9.x = exp2(r9.x);
      r8.w = r9.x * r8.w;
      r7.w = r8.w * r7.w;
      r6.y = r7.w * r6.y;
      r6.y = r6.y * r6.z;
      r7.xyz = r6.yyy * gLightColourAndCapsuleExtent[3].xyz + r7.xyz;
    }
  } else {
    r5.w = -1;
  }
  if (r5.w == 0) {
    r6.y = cmp(4 >= gNumForwardLights);
    r5.w = (int)r5.w | (int)r6.y;
    if (r5.w == 0) {
      r6.y = cmp(gLightColourAndCapsuleExtent[4].w == 0.000000);
      r9.xyz = gLightPositionAndInvDistSqr[4].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[4].xyz + v2.xyz;
      r7.w = dot(r10.xyz, gLightDirectionAndFalloffExponent[4].xyz);
      r8.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[4].w;
      r7.w = saturate(r7.w / r8.w);
      r7.w = gLightColourAndCapsuleExtent[4].w * r7.w;
      r10.xyz = gLightDirectionAndFalloffExponent[4].xyz * r7.www + gLightPositionAndInvDistSqr[4].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r9.xyz = r6.yyy ? r9.xyz : r10.xyz;
      r6.y = dot(r9.xyz, r9.xyz);
      r9.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r9.xyz;
      r7.w = dot(r9.xyz, r9.xyz);
      r7.w = rsqrt(r7.w);
      r9.xyz = r9.xyz * r7.www;
      r6.y = saturate(-r6.y * gLightPositionAndInvDistSqr[4].w + 1);
      r7.w = 1 + -gLightDirectionAndFalloffExponent[4].w;
      r7.w = r7.w * r6.y + gLightDirectionAndFalloffExponent[4].w;
      r6.y = r6.y / r7.w;
      r7.w = dot(r9.xyz, -gLightDirectionAndFalloffExponent[4].xyz);
      r7.w = saturate(r7.w * gLightConeScale[4] + gLightConeOffset[4]);
      r8.w = dot(r9.xyz, r1.yzw);
      r9.w = saturate(r8.w);
      r9.w = r9.w + -abs(r8.w);
      r8.w = r0.w * r9.w + abs(r8.w);
      r7.w = r8.w * r7.w;
      r8.w = r7.w * r6.y;
      r10.xyz = gLightColourAndCapsuleExtent[4].xyz * r8.www;
      r8.xyz = r10.xyz * r0.xyz + r8.xyz;
      r9.xyz = r3.xyz * r3.www + r9.xyz;
      r8.w = dot(r9.xyz, r9.xyz);
      r8.w = rsqrt(r8.w);
      r9.xyz = r9.xyz * r8.www;
      r8.w = saturate(dot(r9.xyz, r4.xyz));
      r8.w = 1 + -r8.w;
      r9.w = r8.w * r8.w;
      r9.w = r9.w * r9.w;
      r8.w = r9.w * r8.w;
      r8.w = r8.w * 0.959999979 + 0.0399999991;
      r9.x = saturate(dot(r9.xyz, r1.yzw));
      r9.x = log2(r9.x);
      r9.x = r9.x * r6.w;
      r9.x = exp2(r9.x);
      r8.w = r9.x * r8.w;
      r7.w = r8.w * r7.w;
      r6.y = r7.w * r6.y;
      r6.y = r6.y * r6.z;
      r7.xyz = r6.yyy * gLightColourAndCapsuleExtent[4].xyz + r7.xyz;
    }
  } else {
    r5.w = -1;
  }
  if (r5.w == 0) {
    r6.y = cmp(5 >= gNumForwardLights);
    r5.w = (int)r5.w | (int)r6.y;
    if (r5.w == 0) {
      r6.y = cmp(gLightColourAndCapsuleExtent[5].w == 0.000000);
      r9.xyz = gLightPositionAndInvDistSqr[5].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[5].xyz + v2.xyz;
      r7.w = dot(r10.xyz, gLightDirectionAndFalloffExponent[5].xyz);
      r8.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[5].w;
      r7.w = saturate(r7.w / r8.w);
      r7.w = gLightColourAndCapsuleExtent[5].w * r7.w;
      r10.xyz = gLightDirectionAndFalloffExponent[5].xyz * r7.www + gLightPositionAndInvDistSqr[5].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r9.xyz = r6.yyy ? r9.xyz : r10.xyz;
      r6.y = dot(r9.xyz, r9.xyz);
      r9.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r9.xyz;
      r7.w = dot(r9.xyz, r9.xyz);
      r7.w = rsqrt(r7.w);
      r9.xyz = r9.xyz * r7.www;
      r6.y = saturate(-r6.y * gLightPositionAndInvDistSqr[5].w + 1);
      r7.w = 1 + -gLightDirectionAndFalloffExponent[5].w;
      r7.w = r7.w * r6.y + gLightDirectionAndFalloffExponent[5].w;
      r6.y = r6.y / r7.w;
      r7.w = dot(r9.xyz, -gLightDirectionAndFalloffExponent[5].xyz);
      r7.w = saturate(r7.w * gLightConeScale[5] + gLightConeOffset[5]);
      r8.w = dot(r9.xyz, r1.yzw);
      r9.w = saturate(r8.w);
      r9.w = r9.w + -abs(r8.w);
      r8.w = r0.w * r9.w + abs(r8.w);
      r7.w = r8.w * r7.w;
      r8.w = r7.w * r6.y;
      r10.xyz = gLightColourAndCapsuleExtent[5].xyz * r8.www;
      r8.xyz = r10.xyz * r0.xyz + r8.xyz;
      r9.xyz = r3.xyz * r3.www + r9.xyz;
      r8.w = dot(r9.xyz, r9.xyz);
      r8.w = rsqrt(r8.w);
      r9.xyz = r9.xyz * r8.www;
      r8.w = saturate(dot(r9.xyz, r4.xyz));
      r8.w = 1 + -r8.w;
      r9.w = r8.w * r8.w;
      r9.w = r9.w * r9.w;
      r8.w = r9.w * r8.w;
      r8.w = r8.w * 0.959999979 + 0.0399999991;
      r9.x = saturate(dot(r9.xyz, r1.yzw));
      r9.x = log2(r9.x);
      r9.x = r9.x * r6.w;
      r9.x = exp2(r9.x);
      r8.w = r9.x * r8.w;
      r7.w = r8.w * r7.w;
      r6.y = r7.w * r6.y;
      r6.y = r6.y * r6.z;
      r7.xyz = r6.yyy * gLightColourAndCapsuleExtent[5].xyz + r7.xyz;
    }
  } else {
    r5.w = -1;
  }
  if (r5.w == 0) {
    r6.y = cmp(6 >= gNumForwardLights);
    r5.w = (int)r5.w | (int)r6.y;
    if (r5.w == 0) {
      r6.y = cmp(gLightColourAndCapsuleExtent[6].w == 0.000000);
      r9.xyz = gLightPositionAndInvDistSqr[6].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[6].xyz + v2.xyz;
      r7.w = dot(r10.xyz, gLightDirectionAndFalloffExponent[6].xyz);
      r8.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[6].w;
      r7.w = saturate(r7.w / r8.w);
      r7.w = gLightColourAndCapsuleExtent[6].w * r7.w;
      r10.xyz = gLightDirectionAndFalloffExponent[6].xyz * r7.www + gLightPositionAndInvDistSqr[6].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r9.xyz = r6.yyy ? r9.xyz : r10.xyz;
      r6.y = dot(r9.xyz, r9.xyz);
      r9.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r9.xyz;
      r7.w = dot(r9.xyz, r9.xyz);
      r7.w = rsqrt(r7.w);
      r9.xyz = r9.xyz * r7.www;
      r6.y = saturate(-r6.y * gLightPositionAndInvDistSqr[6].w + 1);
      r7.w = 1 + -gLightDirectionAndFalloffExponent[6].w;
      r7.w = r7.w * r6.y + gLightDirectionAndFalloffExponent[6].w;
      r6.y = r6.y / r7.w;
      r7.w = dot(r9.xyz, -gLightDirectionAndFalloffExponent[6].xyz);
      r7.w = saturate(r7.w * gLightConeScale[6] + gLightConeOffset[6]);
      r8.w = dot(r9.xyz, r1.yzw);
      r9.w = saturate(r8.w);
      r9.w = r9.w + -abs(r8.w);
      r8.w = r0.w * r9.w + abs(r8.w);
      r7.w = r8.w * r7.w;
      r8.w = r7.w * r6.y;
      r10.xyz = gLightColourAndCapsuleExtent[6].xyz * r8.www;
      r8.xyz = r10.xyz * r0.xyz + r8.xyz;
      r9.xyz = r3.xyz * r3.www + r9.xyz;
      r8.w = dot(r9.xyz, r9.xyz);
      r8.w = rsqrt(r8.w);
      r9.xyz = r9.xyz * r8.www;
      r8.w = saturate(dot(r9.xyz, r4.xyz));
      r8.w = 1 + -r8.w;
      r9.w = r8.w * r8.w;
      r9.w = r9.w * r9.w;
      r8.w = r9.w * r8.w;
      r8.w = r8.w * 0.959999979 + 0.0399999991;
      r9.x = saturate(dot(r9.xyz, r1.yzw));
      r9.x = log2(r9.x);
      r9.x = r9.x * r6.w;
      r9.x = exp2(r9.x);
      r8.w = r9.x * r8.w;
      r7.w = r8.w * r7.w;
      r6.y = r7.w * r6.y;
      r6.y = r6.y * r6.z;
      r7.xyz = r6.yyy * gLightColourAndCapsuleExtent[6].xyz + r7.xyz;
    }
  } else {
    r5.w = -1;
  }
  if (r5.w == 0) {
    r6.y = cmp(7 >= gNumForwardLights);
    r5.w = (int)r5.w | (int)r6.y;
    if (r5.w == 0) {
      r5.w = cmp(gLightColourAndCapsuleExtent[7].w == 0.000000);
      r9.xyz = gLightPositionAndInvDistSqr[7].xyz + -v2.xyz;
      r10.xyz = -gLightPositionAndInvDistSqr[7].xyz + v2.xyz;
      r6.y = dot(r10.xyz, gLightDirectionAndFalloffExponent[7].xyz);
      r7.w = 9.99999975e-05 + gLightColourAndCapsuleExtent[7].w;
      r6.y = saturate(r6.y / r7.w);
      r6.y = gLightColourAndCapsuleExtent[7].w * r6.y;
      r10.xyz = gLightDirectionAndFalloffExponent[7].xyz * r6.yyy + gLightPositionAndInvDistSqr[7].xyz;
      r10.xyz = -v2.xyz + r10.xyz;
      r9.xyz = r5.www ? r9.xyz : r10.xyz;
      r5.w = dot(r9.xyz, r9.xyz);
      r9.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r9.xyz;
      r6.y = dot(r9.xyz, r9.xyz);
      r6.y = rsqrt(r6.y);
      r9.xyz = r9.xyz * r6.yyy;
      r5.w = saturate(-r5.w * gLightPositionAndInvDistSqr[7].w + 1);
      r6.y = 1 + -gLightDirectionAndFalloffExponent[7].w;
      r6.y = r6.y * r5.w + gLightDirectionAndFalloffExponent[7].w;
      r5.w = r5.w / r6.y;
      r6.y = dot(r9.xyz, -gLightDirectionAndFalloffExponent[7].xyz);
      r6.y = saturate(r6.y * gLightConeScale[7] + gLightConeOffset[7]);
      r7.w = dot(r9.xyz, r1.yzw);
      r8.w = saturate(r7.w);
      r8.w = r8.w + -abs(r7.w);
      r7.w = r0.w * r8.w + abs(r7.w);
      r6.y = r7.w * r6.y;
      r7.w = r6.y * r5.w;
      r10.xyz = gLightColourAndCapsuleExtent[7].xyz * r7.www;
      r8.xyz = r10.xyz * r0.xyz + r8.xyz;
      r3.xyz = r3.xyz * r3.www + r9.xyz;
      r3.w = dot(r3.xyz, r3.xyz);
      r3.w = rsqrt(r3.w);
      r3.xyz = r3.xyz * r3.www;
      r3.w = saturate(dot(r3.xyz, r4.xyz));
      r3.w = 1 + -r3.w;
      r7.w = r3.w * r3.w;
      r7.w = r7.w * r7.w;
      r3.w = r7.w * r3.w;
      r3.w = r3.w * 0.959999979 + 0.0399999991;
      r3.x = saturate(dot(r3.xyz, r1.yzw));
      r3.x = log2(r3.x);
      r3.x = r6.w * r3.x;
      r3.x = exp2(r3.x);
      r3.x = r3.w * r3.x;
      r3.x = r3.x * r6.y;
      r3.x = r3.x * r5.w;
      r3.x = r3.x * r6.z;
      r7.xyz = r3.xxx * gLightColourAndCapsuleExtent[7].xyz + r7.xyz;
    }
  }
  r3.x = r6.x * r6.x;
  r2.x = r2.x * r2.x;
  r3.yzw = r2.xxx * r7.xyz;
  r3.xyz = r3.xxx * r8.xyz + r3.yzw;
  r3.xyz = r5.xyz * r4.www + r3.xyz;
  r1.x = v1.z * r1.x + gLightNaturalAmbient0.w;
  r1.x = gLightNaturalAmbient1.w * r1.x;
  r1.x = max(0, r1.x);
  r5.xyz = gLightArtificialExtAmbient0.xyz * r1.xxx + gLightArtificialExtAmbient1.xyz;
  r2.x = 1 + -globalScalars2.z;
  r6.yzw = gLightArtificialIntAmbient0.xyz * r1.xxx + gLightArtificialIntAmbient1.xyz;
  r6.yzw = globalScalars2.zzz * r6.yzw;
  r5.xyz = r5.xyz * r2.xxx + r6.yzw;
  r5.xyz = r5.xyz * r2.zzz;
  r6.yzw = gLightNaturalAmbient0.xyz * r1.xxx + gLightNaturalAmbient1.xyz;
  r7.x = gLightArtificialIntAmbient1.w;
  r7.y = gLightArtificialExtAmbient0.w;
  r7.z = gLightArtificialExtAmbient1.w;
  r1.x = saturate(dot(r7.xyz, r1.yzw));
  r6.yzw = gDirectionalAmbientColour.xyz * r1.xxx + r6.yzw;
  r5.xyz = r6.yzw * r2.yyy + r5.xyz;
  r5.xyz = r5.xyz * r6.xxx;
  r0.xyz = r5.xyz * r0.xyz + r3.xyz;
  r1.x = 1 + -r6.x;
  r2.x = dot(-r4.xyz, r1.yzw);
  r2.x = r2.x + r2.x;
  r1.yzw = r1.yzw * -r2.xxx + -r4.xyz;
  r2.xw = saturate(float2(0.000666666718,0.00177619897) * r2.ww);
  r2.x = 1 + -r2.x;
  r3.x = -5 + gReflectionMipCount;
  r3.y = gReflectionMipCount * r2.x;
  r3.y = cmp(r3.y < r3.x);
  r3.z = r2.x * gReflectionMipCount + -5;
  r2.x = r2.x * r2.x;
  r2.x = r2.x * 5 + r3.x;
  r2.x = r3.y ? r3.z : r2.x;
  r3.xyz = float3(-0.25,0.5,0.25) * r1.yzy;
  r1.y = 1 + abs(r1.w);
  r3.xyz = r3.xyz / r1.yyy;
  r3.xyz = float3(0.75,0.5,0.25) + -r3.xyz;
  r1.y = cmp(0 < r1.w);
  r1.yz = r1.yy ? r3.xy : r3.zy;
  r3.xyzw = ReflectionSampler.SampleLevel(ReflectionSampler_s, r1.yz, r2.x).xyzw;
  r1.y = max(r2.y, r2.z);
  r1.yzw = r3.xyz * r1.yyy;
  r2.xyz = r1.yzw * r2.www;
  r2.xyz = float3(0.681690097,0.681690097,0.681690097) * r2.xyz;
  r1.yzw = r1.yzw * float3(0.318309903,0.318309903,0.318309903) + r2.xyz;
  r0.xyz = r1.yzw * r1.xxx + r0.xyz;
  o0.w = saturate(globalScalars.x * r0.w);
  r0.w = cmp(0 < gGlobalFogIntensity);
  if (r0.w != 0) {
    r1.xy = globalScreenSize.zw * v6.xy;
    r1.xyzw = FogRaySampler.Sample(FogRaySampler_s, r1.xy).xyzw;
    r0.w = -1 + r1.x;
    r0.w = saturate(gGlobalFogIntensity * r0.w + 1);
  } else {
    r0.w = 1;
  }
  r0.w = v5.w * r0.w;
  r1.xyz = v5.xyz + -r0.xyz;
  r0.xyz = r0.www * r1.xyz + r0.xyz;
  o0.xyz = globalScalars3.zzz * r0.xyz;
  return;
}