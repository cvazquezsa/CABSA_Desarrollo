[Forma]
Clave=ContAuto
Nombre=<T>Contabilidad Automática - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=129
PosicionInicialArriba=132
PosicionInicialAlturaCliente=493
PosicionInicialAncho=832
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

VentanaEstadoInicial=Normal
ExpresionesAlMostrar=Asigna(Info.Empresa, <T>(Todas)<T>)
Comentarios=e(<T>Empresa<T>)+<T>: <T>+Info.Empresa
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovClave
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=MovClave.Folio<TAB>(Acendente)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PermiteEditar=S
FiltroGeneral=MovClave.Modulo=<T>{Info.Modulo}<T>

[Lista.MovClave.Clave]
Carpeta=Lista
Clave=MovClave.Clave
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovClave.Folio]
Carpeta=Lista
Clave=MovClave.Folio
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Clave=68
Descripcion=177
Folio=34
NombreOmision=261
ContAuto=60
ContMov=98
ContConcepto=91
EstatusContabilizar=101
AfectarPresupuesto=107

Empresa=71
Nombre=371
[Lista.MovClave.NombreOmision]
Carpeta=Lista
Clave=MovClave.NombreOmision
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovClave.Descripcion]
Carpeta=Lista
Clave=MovClave.Descripcion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
GuardarAntes=S

[Acciones.Poliza]
Nombre=Poliza
Boton=47
NombreEnBoton=S
NombreDesplegar=&Póliza por Omisión
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovTipoContAuto
Visible=S
Antes=S
ActivoCondicion=ConDatos(MovClave:MovClave.ContMov)
AntesExpresiones=Asigna(Info.Clave, <T>(<T>+MovClave:MovClave.Clave+<T>)<T>)<BR>Asigna(Info.MovTipo, MovClave:MovClave.Clave)<BR>Asigna(Info.Factor, MovClave:MovClave.Factor)

[Lista.MovClave.ContMov]
Carpeta=Lista
Clave=MovClave.ContMov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Movimiento Especifico]
Nombre=Movimiento Especifico
Boton=30
NombreEnBoton=S
NombreDesplegar=&Movimiento Específico
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ContAutoD
Antes=S
Visible=S

ActivoCondicion=ConDatos(MovClave:MovClave.ContMov)
AntesExpresiones=Asigna(Info.MovTipo, MovClave:MovClave.Clave)<BR>Asigna(Info.Factor, MovClave:MovClave.Factor)
[Lista.MovClave.EstatusContabilizar]
Carpeta=Lista
Clave=MovClave.EstatusContabilizar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovClave.AfectarPresupuesto]
Carpeta=Lista
Clave=MovClave.AfectarPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]


[Lista.ListaEnCaptura]
(Inicio)=MovClave.Folio
MovClave.Folio=MovClave.Clave
MovClave.Clave=MovClave.NombreOmision
MovClave.NombreOmision=MovClave.Descripcion
MovClave.Descripcion=MovClave.ContMov
MovClave.ContMov=MovClave.AfectarPresupuesto
MovClave.AfectarPresupuesto=MovClave.EstatusContabilizar
MovClave.EstatusContabilizar=(Fin)








[Acciones.EmpresaEspecifica]
Nombre=EmpresaEspecifica
Boton=107
NombreEnBoton=S
NombreDesplegar=&Empresa Específica
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S























Expresion=Si(no Forma(<T>EspecificarEmpresa<T>), AbortarOperacion)<BR> Forma.ActualizarTitulos






[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Poliza
Poliza=Movimiento Especifico
Movimiento Especifico=EmpresaEspecifica
EmpresaEspecifica=(Fin)
