
[Forma]
Clave=MFALayoutDocumentoD
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=MFA - Captura Manual Documentos
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
Comentarios=Lista(Info.Ejercicio,Info.Periodo,Info.MovID)
PosicionInicialAlturaCliente=591
PosicionInicialAncho=1120
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=80
PosicionInicialArriba=60
ListaAcciones=Aceptar
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFALayoutDocumentoD
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=DocumentoID = {Comillas(Info.Categoria)}
[Lista.MFALayoutDocumentoD.concepto]
Carpeta=Lista
Clave=MFALayoutDocumentoD.concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.MFALayoutDocumentoD.acumulable_deducible]
Carpeta=Lista
Clave=MFALayoutDocumentoD.acumulable_deducible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFALayoutDocumentoD.importe]
Carpeta=Lista
Clave=MFALayoutDocumentoD.importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFALayoutDocumentoD.retencion_isr]
Carpeta=Lista
Clave=MFALayoutDocumentoD.retencion_isr
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFALayoutDocumentoD.retencion_iva]
Carpeta=Lista
Clave=MFALayoutDocumentoD.retencion_iva
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFALayoutDocumentoD.base_iva]
Carpeta=Lista
Clave=MFALayoutDocumentoD.base_iva
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFALayoutDocumentoD.iva_excento]
Carpeta=Lista
Clave=MFALayoutDocumentoD.iva_excento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFALayoutDocumentoD.iva_tasa]
Carpeta=Lista
Clave=MFALayoutDocumentoD.iva_tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFALayoutDocumentoD.iva]
Carpeta=Lista
Clave=MFALayoutDocumentoD.iva
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFALayoutDocumentoD.base_ieps]
Carpeta=Lista
Clave=MFALayoutDocumentoD.base_ieps
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFALayoutDocumentoD.ieps_tasa]
Carpeta=Lista
Clave=MFALayoutDocumentoD.ieps_tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFALayoutDocumentoD.ieps]
Carpeta=Lista
Clave=MFALayoutDocumentoD.ieps
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFALayoutDocumentoD.base_isan]
Carpeta=Lista
Clave=MFALayoutDocumentoD.base_isan
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFALayoutDocumentoD.isan]
Carpeta=Lista
Clave=MFALayoutDocumentoD.isan
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFALayoutDocumentoD.importe_total]
Carpeta=Lista
Clave=MFALayoutDocumentoD.importe_total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
concepto=82
concepto_descripcion=151
acumulable_deducible=69
importe=75
retencion_isr=78
retencion_iva=72
base_iva=85
iva_excento=64
iva_tasa=48
iva=64
base_ieps=64
ieps_tasa=52
ieps=48
base_isan=64
isan=64
importe_total=82


[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S













[Lista.ListaEnCaptura]
(Inicio)=MFALayoutDocumentoD.concepto
MFALayoutDocumentoD.concepto=MFALayoutDocumentoD.acumulable_deducible
MFALayoutDocumentoD.acumulable_deducible=MFALayoutDocumentoD.importe
MFALayoutDocumentoD.importe=MFALayoutDocumentoD.base_ieps
MFALayoutDocumentoD.base_ieps=MFALayoutDocumentoD.ieps_tasa
MFALayoutDocumentoD.ieps_tasa=MFALayoutDocumentoD.ieps
MFALayoutDocumentoD.ieps=MFALayoutDocumentoD.iva_excento
MFALayoutDocumentoD.iva_excento=MFALayoutDocumentoD.base_iva
MFALayoutDocumentoD.base_iva=MFALayoutDocumentoD.iva_tasa
MFALayoutDocumentoD.iva_tasa=MFALayoutDocumentoD.iva
MFALayoutDocumentoD.iva=MFALayoutDocumentoD.base_isan
MFALayoutDocumentoD.base_isan=MFALayoutDocumentoD.isan
MFALayoutDocumentoD.isan=MFALayoutDocumentoD.retencion_isr
MFALayoutDocumentoD.retencion_isr=MFALayoutDocumentoD.retencion_iva
MFALayoutDocumentoD.retencion_iva=MFALayoutDocumentoD.importe_total
MFALayoutDocumentoD.importe_total=(Fin)
