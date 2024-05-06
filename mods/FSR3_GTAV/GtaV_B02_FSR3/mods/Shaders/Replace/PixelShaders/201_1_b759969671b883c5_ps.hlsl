// ---- FNV Hash b759969671b883c5

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

cbuffer vehiclecommonlocals : register(b12)
{
  float3 matDiffuseColor : packoffset(c0);
  float4 matDiffuseColor2 : packoffset(c1);
  float emissiveMultiplier : packoffset(c2);
  float4 dirtLevelMod : packoffset(c3);
  float3 specMapIntMask : packoffset(c4);
  float reflectivePower : packoffset(c4.w);
  float envEffThickness : packoffset(c5);
  float2 envEffScale : packoffset(c5.y);
  float envEffTexTileUV : packoffset(c5.w);
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
SamplerState SpecSampler_s : register(s2);
SamplerState FogRaySampler_s : register(s11);
SamplerComparisonState gCSMShadowTextureSamp_s : register(s15);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> ReflectionSampler : register(t1);
Texture2D<float4> SpecSampler : register(t2);
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
  float4 v5 : SV_Position0,
  float4 v6 : SV_ClipDistance0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21,r22,r23,r24;
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
  r2.x = v4.x * r2.x;
  r0.xyz = matDiffuseColor.xyz * r0.xyz;
  r0.w = v4.w * r0.w;
  r2.y = saturate(gDirectionalAmbientColour.w + globalScalars2.z);
  r2.y = globalScalars.y * r2.y;
  r2.z = emissiveMultiplier * v4.x;
  r2.xz = dirtLevelMod.zz * r2.xz;
  r2.x = saturate(0.400000006 * r2.x);
  r0.xyz = r0.xyz * r0.xyz;
  r3.xyz = gViewInverse._m30_m31_m32 + -v2.xyz;
  r3.w = dot(r3.xyz, r3.xyz);
  r3.w = rsqrt(r3.w);
  r4.xyz = r3.xyz * r3.www;
  r5.xyz = r3.xyz * r3.www + -gDirectionalLight.xyz;
  r3.w = dot(r5.xyz, r5.xyz);
  r3.w = rsqrt(r3.w);
  r5.xyz = r5.xyz * r3.www;
  r3.w = globalScalars.z * globalScalars.z;
  r2.y = r2.y * r2.y;
  r4.w = r2.w * 512 + -500;
  r4.w = max(0, r4.w);
  r2.w = r2.w * 512 + -r4.w;
  r4.w = 558 * r4.w;
  r2.w = r2.w * 3 + r4.w;
  r3.x = dot(r3.xyz, gViewInverse._m20_m21_m22);
  r6.xyz = -gViewInverse._m30_m31_m32 + v2.xyz;
  r7.xyz = gCSMShaderVars_shared[1].xyz * r6.yyy;
  r7.xyz = r6.xxx * gCSMShaderVars_shared[0].xyz + r7.xyz;
  r7.xyz = r6.zzz * gCSMShaderVars_shared[2].xyz + r7.xyz;
  r8.xyz = r7.xyz * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
  x0[0].xyz = r8.xyz;
  r9.xyz = r7.xyz * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
  x0[1].xyz = r9.xyz;
  r10.xyz = r7.xyz * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
  x0[2].xyz = r10.xyz;
  r7.xyz = r7.xyz * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
  x0[3].xyz = r7.xyz;
  r11.yw = float2(-0.346096486,0.32848981) * gCSMResolution.zw;
  r3.y = -gCSMResolution.z * 1.5 + 1;
  r3.y = 0.5 * r3.y;
  r3.z = max(abs(r10.x), abs(r10.y));
  r3.z = cmp(r3.z < r3.y);
  r3.z = r3.z ? 2 : 3;
  r4.w = max(abs(r9.x), abs(r9.y));
  r4.w = cmp(r4.w < r3.y);
  r3.z = r4.w ? 1 : r3.z;
  r4.w = max(abs(r8.x), abs(r8.y));
  r3.y = cmp(r4.w < r3.y);
  r3.y = r3.y ? 0 : r3.z;
  r8.xyz = x0[r3.y+0].xyz;
  r3.y = (int)r3.y;
  r3.z = 0.5 + r3.y;
  r3.z = 0.25 * r3.z;
  r9.xyzw = cmp(float4(0,1,2,3) == r3.yyyy);
  r9.xyzw = r9.xyzw ? float4(1,1,1,1) : 0;
  r3.y = dot(r9.xyzw, gCSMDepthBias.xyzw);
  r4.w = dot(r9.xyzw, gCSMDepthSlopeBias.xyzw);
  r9.x = 0.5 + r8.x;
  r9.y = r8.y * 0.25 + r3.z;
  r3.z = cmp(r3.y != 0.000000);
  r3.y = r8.z + -r3.y;
  r10.xyw = ddx(r9.xyy);
  r10.z = ddx(r3.y);
  r12.xyz = ddy(r9.yxy);
  r12.w = ddy(r3.y);
  r7.zw = r12.yw * r10.yw;
  r13.xy = r10.xz * r12.xz + -r7.zw;
  r5.w = 1 / r13.x;
  r6.w = r12.y * r10.z;
  r13.z = r10.x * r12.w + -r6.w;
  r7.zw = r13.yz * r5.ww;
  r7.zw = max(float2(0,0), r7.zw);
  r7.zw = min(float2(0.5,0.5), r7.zw);
  r3.y = -r4.w * r7.z + r3.y;
  r3.y = -r4.w * r7.w + r3.y;
  r11.z = r3.z ? r3.y : r8.z;
  r9.z = 0;
  r8.xyz = r11.ywz + r9.xyz;
  r11.xy = float2(-0.799291492,0.201740593) * gCSMResolution.zw;
  r10.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.0311755091,0.1793378) * gCSMResolution.zw;
  r12.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(0.514749527,0.253502488) * gCSMResolution.zw;
  r13.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.0728697181,0.00809734128) * gCSMResolution.zw;
  r14.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.96978128,0.0345216095) * gCSMResolution.zw;
  r15.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(0.54554671,0.0241285395) * gCSMResolution.zw;
  r16.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.0289061107,-0.136784598) * gCSMResolution.zw;
  r17.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.479511499,-0.244832903) * gCSMResolution.zw;
  r18.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(0.758788407,-0.112109199) * gCSMResolution.zw;
  r19.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(0.339352608,-0.249327794) * gCSMResolution.zw;
  r20.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(1.07059801,0.208122596) * gCSMResolution.zw;
  r21.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(1.29403806,-0.0180776808) * gCSMResolution.zw;
  r22.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-0.747563124,-0.113974303) * gCSMResolution.zw;
  r23.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(0.94772172,-0.248763502) * gCSMResolution.zw;
  r24.xyz = r11.xyz + r9.xyz;
  r11.xy = float2(-1.343153,-0.088584058) * gCSMResolution.zw;
  r9.xyz = r11.xyz + r9.xyz;
  r8.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r8.xy, r8.z).x;
  r8.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r10.xy, r10.z).x;
  r8.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r12.xy, r12.z).x;
  r8.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r13.xy, r13.z).x;
  r10.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r14.xy, r14.z).x;
  r10.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r15.xy, r15.z).x;
  r10.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r16.xy, r16.z).x;
  r10.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r17.xy, r17.z).x;
  r11.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r18.xy, r18.z).x;
  r11.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r19.xy, r19.z).x;
  r11.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r20.xy, r20.z).x;
  r11.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r21.xy, r21.z).x;
  r12.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r22.xy, r22.z).x;
  r12.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r23.xy, r23.z).x;
  r12.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r24.xy, r24.z).x;
  r12.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r9.xy, r9.z).x;
  r8.xyzw = r10.xyzw + r8.xyzw;
  r8.xyzw = r8.xyzw + r11.xyzw;
  r8.xyzw = r8.xyzw + r12.xyzw;
  r3.y = dot(r8.xyzw, float4(1,1,1,1));
  r3.x = saturate(r3.x * gCSMShaderVars_shared[0].w + gCSMShaderVars_shared[1].w);
  r3.z = max(abs(r7.x), abs(r7.y));
  r3.z = saturate(r3.z * 15 + -6.30000019);
  r3.x = 1 + -r3.x;
  r3.x = r3.x * r3.z;
  r3.x = r3.y * 0.0625 + r3.x;
  r3.x = r3.x * r3.x;
  r3.x = min(1, r3.x);
  r3.y = saturate(v2.z * gCSMShaderVars_shared[3].x + gCSMShaderVars_shared[3].y);
  r3.y = sqrt(r3.y);
  r3.y = gCSMShaderVars_shared[3].z * r3.y;
  r3.x = r3.y * -r3.x + r3.x;
  r3.y = saturate(dot(r1.yzw, -gDirectionalLight.xyz));
  r7.x = saturate(dot(r4.xyz, r1.yzw));
  r7.y = saturate(dot(r5.xyz, -gDirectionalLight.xyz));
  r7.yz = float2(1,1) + -r7.xy;
  r8.xy = r7.yz * r7.yz;
  r8.xy = r8.xy * r8.xy;
  r7.yz = r8.xy * r7.yz;
  r7.yz = r7.yz * float2(0.967999995,0.967999995) + float2(0.0320000015,0.0320000015);
  r8.xy = float2(2,9.99999994e-09) + r2.ww;
  r3.z = 0.125 * r8.x;
  r4.w = -r2.x * r7.y + 1;
  r5.x = dot(r1.yzw, r5.xyz);
  r5.x = saturate(9.99999994e-09 + r5.x);
  r5.x = log2(r5.x);
  r5.x = r8.y * r5.x;
  r5.x = exp2(r5.x);
  r5.x = r5.x * r7.z;
  r3.z = r5.x * r3.z;
  r2.x = r3.z * r2.x;
  r2.x = r2.x * r3.y;
  r3.y = r4.w * r3.y;
  r5.xyz = r0.xyz * r3.yyy + r2.xxx;
  r5.xyz = gDirectionalColour.xyz * r5.xyz;
  r1.x = v1.z * r1.x + gLightNaturalAmbient0.w;
  r1.x = gLightNaturalAmbient1.w * r1.x;
  r1.x = max(0, r1.x);
  r7.yzw = gLightArtificialExtAmbient0.xyz * r1.xxx + gLightArtificialExtAmbient1.xyz;
  r2.x = 1 + -globalScalars2.z;
  r8.xyz = gLightArtificialIntAmbient0.xyz * r1.xxx + gLightArtificialIntAmbient1.xyz;
  r8.xyz = globalScalars2.zzz * r8.xyz;
  r7.yzw = r7.yzw * r2.xxx + r8.xyz;
  r7.yzw = r7.yzw * r2.yyy;
  r8.xyz = gLightNaturalAmbient0.xyz * r1.xxx + gLightNaturalAmbient1.xyz;
  r9.x = gLightArtificialIntAmbient1.w;
  r9.y = gLightArtificialExtAmbient0.w;
  r9.z = gLightArtificialExtAmbient1.w;
  r1.x = saturate(dot(r9.xyz, r1.yzw));
  r8.xyz = gDirectionalAmbientColour.xyz * r1.xxx + r8.xyz;
  r7.yzw = r8.xyz * r3.www + r7.yzw;
  r7.yzw = r7.yzw * r4.www;
  r7.yzw = r7.yzw * r0.xyz;
  r3.xyz = r5.xyz * r3.xxx + r7.yzw;
  r1.x = 1 + -r4.w;
  r2.x = dot(-r4.xyz, r1.yzw);
  r2.x = r2.x + r2.x;
  r1.yzw = r1.yzw * -r2.xxx + -r4.xyz;
  r2.xw = saturate(float2(0.000666666718,0.00177619897) * r2.ww);
  r2.x = 1 + -r2.x;
  r4.x = -5 + gReflectionMipCount;
  r4.y = gReflectionMipCount * r2.x;
  r4.y = cmp(r4.y < r4.x);
  r4.z = r2.x * gReflectionMipCount + -5;
  r2.x = r2.x * r2.x;
  r2.x = r2.x * 5 + r4.x;
  r2.x = r4.y ? r4.z : r2.x;
  r4.xyz = float3(-0.25,0.5,0.25) * r1.yzy;
  r1.y = 1 + abs(r1.w);
  r4.xyz = r4.xyz / r1.yyy;
  r4.xyz = float3(0.75,0.5,0.25) + -r4.xyz;
  r1.y = cmp(0 < r1.w);
  r1.yz = r1.yy ? r4.xy : r4.zy;
  r4.xyzw = ReflectionSampler.SampleLevel(ReflectionSampler_s, r1.yz, r2.x).xyzw;
  r1.y = max(r3.w, r2.y);
  r1.yzw = r4.xyz * r1.yyy;
  r2.xyw = r1.yzw * r2.www;
  r2.xyw = float3(0.681690097,0.681690097,0.681690097) * r2.xyw;
  r1.yzw = r1.yzw * float3(0.318309903,0.318309903,0.318309903) + r2.xyw;
  r1.xyz = r1.yzw * r1.xxx + r3.xyz;
  r1.w = r7.x * r2.z;
  r0.xyz = r0.xyz * r1.www + r1.xyz;
  o0.w = saturate(globalScalars.x * r0.w);
  r0.w = dot(r6.xyz, r6.xyz);
  r1.x = sqrt(r0.w);
  r1.y = -globalFogParams[0].x + r1.x;
  r1.y = max(0, r1.y);
  r1.x = r1.y / r1.x;
  r1.x = r6.z * r1.x;
  r1.z = globalFogParams[2].z * r1.x;
  r1.x = cmp(0.00999999978 < abs(r1.x));
  r1.w = -1.44269502 * r1.z;
  r1.w = exp2(r1.w);
  r1.w = 1 + -r1.w;
  r1.z = r1.w / r1.z;
  r1.x = r1.x ? r1.z : 1;
  r1.z = globalFogParams[1].w * r1.y;
  r1.x = r1.z * r1.x;
  r1.x = min(1, r1.x);
  r1.x = 1.44269502 * r1.x;
  r1.x = exp2(r1.x);
  r1.x = min(1, r1.x);
  r1.x = 1 + -r1.x;
  r1.z = globalFogParams[2].y * r1.x;
  r0.w = rsqrt(r0.w);
  r2.xyz = r6.xyz * r0.www;
  r0.w = saturate(dot(r2.xyz, globalFogParams[4].xyz));
  r0.w = log2(r0.w);
  r0.w = globalFogParams[4].w * r0.w;
  r0.w = exp2(r0.w);
  r1.w = saturate(dot(r2.xyz, globalFogParams[3].xyz));
  r1.w = log2(r1.w);
  r1.w = globalFogParams[3].w * r1.w;
  r1.w = exp2(r1.w);
  r1.x = -r1.x * globalFogParams[2].y + 1;
  r1.x = globalFogParams[1].y * r1.x;
  r2.x = -globalFogParams[2].x + r1.y;
  r2.x = max(0, r2.x);
  r2.x = globalFogParams[1].x * r2.x;
  r2.x = 1.44269502 * r2.x;
  r2.x = exp2(r2.x);
  r2.x = 1 + -r2.x;
  r1.z = saturate(r1.x * r2.x + r1.z);
  r1.y = -globalFogParams[1].z * r1.y;
  r1.y = 1.44269502 * r1.y;
  r1.y = exp2(r1.y);
  r1.y = 1 + -r1.y;
  r2.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
  r2.xyz = r0.www * r2.xyz + globalFogColorE.xyz;
  r3.xyz = globalFogColor.xyz + -r2.xyz;
  r2.xyz = r1.www * r3.xyz + r2.xyz;
  r2.xyz = -globalFogColorN.xyz + r2.xyz;
  r2.xyz = r1.yyy * r2.xyz + globalFogColorN.xyz;
  r3.x = globalFogColor.w + -r2.x;
  r3.y = globalFogColorE.w + -r2.y;
  r3.z = globalFogColorN.w + -r2.z;
  r1.xyw = r1.xxx * r3.xyz + r2.xyz;
  r0.w = cmp(0 < gGlobalFogIntensity);
  if (r0.w != 0) {
    r2.xy = globalScreenSize.zw * v5.xy;
    r2.xyzw = FogRaySampler.Sample(FogRaySampler_s, r2.xy).xyzw;
    r0.w = -1 + r2.x;
    r0.w = saturate(gGlobalFogIntensity * r0.w + 1);
  } else {
    r0.w = 1;
  }
  r1.xyw = r1.xyw * r0.www + -r0.xyz;
  r0.xyz = r1.zzz * r1.xyw + r0.xyz;
  o0.xyz = globalScalars3.zzz * r0.xyz;
  return;
}