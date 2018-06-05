[Forma]
Clave=CFDFlexConcepto
Nombre=<T>Conceptos &Régimen Fiscal - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=613
PosicionInicialArriba=229
PosicionInicialAltura=400
PosicionInicialAncho=373
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=373

VentanaEstadoInicial=Normal
Comentarios=Info.Concepto
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDFlexConcepto
Fuente={MS Sans Serif, 8, Negro, []}
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
FiltroAncho=30
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
CarpetaVisible=S
PermiteLocalizar=S
HojaAjustarColumnas=S
HojaMantenerSeleccion=S


FiltroGeneral=CFDFlexConcepto.Modulo=<T>{Info.Modulo}<T> AND CFDFlexConcepto.Concepto=<T>{Info.Concepto}<T>
[Lista.Columnas]
Concepto=177
Bloqueo=90
Orden=36
EsDeducible=51
ConSueldo=88
Cuenta=112
Impuestos=35
Retencion=86
Retencion2=86
Clase=88
SubClase=79
ValidarPresupuesto=75
Tipo=47
Actividad=71
PorcentajeDeducible=64
CR=123
NivelAcceso=100
UEN=39
Retencion3=75
CuentaPresupuesto=103
Numero=44

FiscalRegimen=254
Empresa=76
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S










EspacioPrevio=S
ActivoCondicion=Usuario.EnviarExcel

[Lista.CFDFlexConcepto.FiscalRegimen]
Carpeta=Lista
Clave=CFDFlexConcepto.FiscalRegimen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco































[Lista.CFDFlexConcepto.Empresa]
Carpeta=Lista
Clave=CFDFlexConcepto.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco










[Lista.ListaEnCaptura]
(Inicio)=CFDFlexConcepto.Empresa
CFDFlexConcepto.Empresa=CFDFlexConcepto.FiscalRegimen
CFDFlexConcepto.FiscalRegimen=(Fin)





















[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)
