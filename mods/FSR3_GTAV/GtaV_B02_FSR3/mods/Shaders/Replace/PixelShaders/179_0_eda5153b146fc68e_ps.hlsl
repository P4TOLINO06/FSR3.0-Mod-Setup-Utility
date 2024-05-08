// ---- FNV Hash eda5153b146fc68e

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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
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
  r3.xyz = r3.xyz * r3.www + -gDirectionalLight.xyz;
  r3.w = dot(r3.xyz, r3.xyz);
  r3.w = rsqrt(r3.w);
  r3.xyz = r3.xyz * r3.www;
  r2.yz = r2.yz * r2.yz;
  r3.w = r2.w * 510 + -500;
  r3.w = max(0, r3.w);
  r2.w = r2.w * 510 + -r3.w;
  r3.w = 558 * r3.w;
  r2.w = r2.w * 3 + r3.w;
  r5.xyz = -gViewInverse._m30_m31_m32 + v2.xyz;
  r6.xyz = gCSMShaderVars_shared[1].xyz * r5.yyy;
  r5.xyw = r5.xxx * gCSMShaderVars_shared[0].xyz + r6.xyz;
  r5.xyz = r5.zzz * gCSMShaderVars_shared[2].xyz + r5.xyw;
  r6.xyz = r5.xyz * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
  x0[0].xyz = r6.xyz;
  r7.xyz = r5.xyz * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
  x0[1].xyz = r7.xyz;
  r8.xyz = r5.xyz * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
  x0[2].xyz = r8.xyz;
  r5.xyz = r5.xyz * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
  x0[3].xyz = r5.xyz;
  r3.w = -gCSMResolution.z * 1.5 + 1;
  r3.w = 0.5 * r3.w;
  r4.w = max(abs(r8.x), abs(r8.y));
  r4.w = cmp(r4.w < r3.w);
  r4.w = r4.w ? 2 : 3;
  r5.x = max(abs(r7.x), abs(r7.y));
  r5.x = cmp(r5.x < r3.w);
  r4.w = r5.x ? 1 : r4.w;
  r5.x = max(abs(r6.x), abs(r6.y));
  r3.w = cmp(r5.x < r3.w);
  r3.w = r3.w ? 0 : r4.w;
  r5.xyz = x0[r3.w+0].xyz;
  r3.w = (int)r3.w;
  r4.w = 0.5 + r3.w;
  r4.w = 0.25 * r4.w;
  r6.xyzw = cmp(float4(0,1,2,3) == r3.wwww);
  r6.xyzw = r6.xyzw ? float4(1,1,1,1) : 0;
  r3.w = dot(r6.xyzw, gCSMDepthBias.xyzw);
  r5.w = dot(r6.xyzw, gCSMDepthSlopeBias.xyzw);
  r6.x = 0.5 + r5.x;
  r6.y = r5.y * 0.25 + r4.w;
  r4.w = cmp(r3.w != 0.000000);
  r3.w = r5.z + -r3.w;
  r7.xyw = ddx(r6.xyy);
  r7.z = ddx(r3.w);
  r8.xyz = ddy(r6.yxy);
  r8.w = ddy(r3.w);
  r5.xy = r8.yw * r7.yw;
  r9.xy = r7.xz * r8.xz + -r5.xy;
  r5.x = 1 / r9.x;
  r5.y = r8.y * r7.z;
  r9.z = r7.x * r8.w + -r5.y;
  r5.xy = r9.yz * r5.xx;
  r5.xy = max(float2(0,0), r5.xy);
  r5.xy = min(float2(0.5,0.5), r5.xy);
  r3.w = -r5.w * r5.x + r3.w;
  r3.w = -r5.w * r5.y + r3.w;
  r3.w = r4.w ? r3.w : r5.z;
  r3.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r6.xy, r3.w).x;
  r4.w = dot(r1.yzw, -gDirectionalLight.xyz);
  r5.x = saturate(r4.w);
  r5.x = r5.x + -abs(r4.w);
  r4.w = r0.w * r5.x + abs(r4.w);
  r5.x = saturate(dot(r4.xyz, r1.yzw));
  r5.y = saturate(dot(r3.xyz, -gDirectionalLight.xyz));
  r5.xy = float2(1,1) + -r5.xy;
  r5.zw = r5.xy * r5.xy;
  r5.zw = r5.zw * r5.zw;
  r5.xy = r5.zw * r5.xy;
  r5.xy = r5.xy * float2(0.959999979,0.959999979) + float2(0.0399999991,0.0399999991);
  r5.zw = float2(2,9.99999994e-09) + r2.ww;
  r5.z = 0.125 * r5.z;
  r5.x = -r2.x * r5.x + 1;
  r3.x = dot(r1.yzw, r3.xyz);
  r3.x = saturate(9.99999994e-09 + r3.x);
  r3.x = log2(r3.x);
  r3.x = r5.w * r3.x;
  r3.x = exp2(r3.x);
  r3.x = r3.x * r5.y;
  r3.x = r3.x * r5.z;
  r2.x = r3.x * r2.x;
  r2.x = r2.x * r4.w;
  r3.x = r5.x * r4.w;
  r3.xyz = r0.xyz * r3.xxx + r2.xxx;
  r3.xyz = gDirectionalColour.xyz * r3.xyz;
  r1.x = v1.z * r1.x + gLightNaturalAmbient0.w;
  r1.x = gLightNaturalAmbient1.w * r1.x;
  r1.x = max(0, r1.x);
  r5.yzw = gLightArtificialExtAmbient0.xyz * r1.xxx + gLightArtificialExtAmbient1.xyz;
  r2.x = 1 + -globalScalars2.z;
  r6.xyz = gLightArtificialIntAmbient0.xyz * r1.xxx + gLightArtificialIntAmbient1.xyz;
  r6.xyz = globalScalars2.zzz * r6.xyz;
  r5.yzw = r5.yzw * r2.xxx + r6.xyz;
  r5.yzw = r5.yzw * r2.zzz;
  r6.xyz = gLightNaturalAmbient0.xyz * r1.xxx + gLightNaturalAmbient1.xyz;
  r7.x = gLightArtificialIntAmbient1.w;
  r7.y = gLightArtificialExtAmbient0.w;
  r7.z = gLightArtificialExtAmbient1.w;
  r1.x = saturate(dot(r7.xyz, r1.yzw));
  r6.xyz = gDirectionalAmbientColour.xyz * r1.xxx + r6.xyz;
  r5.yzw = r6.xyz * r2.yyy + r5.yzw;
  r5.yzw = r5.yzw * r5.xxx;
  r0.xyz = r5.yzw * r0.xyz;
  r0.xyz = r3.xyz * r3.www + r0.xyz;
  r1.x = 1 + -r5.x;
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