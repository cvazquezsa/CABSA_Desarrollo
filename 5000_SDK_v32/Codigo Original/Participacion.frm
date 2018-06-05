[Forma]
Clave=Participacion
Nombre=Otras Participaciones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=121
PosicionInicialArriba=183
PosicionInicialAlturaCliente=368
PosicionInicialAncho=849
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaParticipacion
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=EmpresaParticipacion.Empresa=<T>{Empresa}<T>

[Lista.EmpresaParticipacion.Simbolo]
Carpeta=Lista
Clave=EmpresaParticipacion.Simbolo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaParticipacion.Resultado]
Carpeta=Lista
Clave=EmpresaParticipacion.Resultado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Lista.Columnas]
Tipo=124
Simbolo=127
Resultado=142
Descripcion=342
UltimoCambio=139
Moneda=64

[Lista.EmpresaParticipacion.Descripcion]
Carpeta=Lista
Clave=EmpresaParticipacion.Descripcion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreEnBoton=S
NombreDesplegar=&Actualizar Resultados Empresas
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
Activo=S
Visible=S
ClaveAccion=Actualizar Vista
Antes=S
AntesExpresiones=EjecutarSQL(<T>spEmpresaParticipacionCalc :tEmpresa<T>, Empresa)
DespuesGuardar=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Poliza]
Nombre=Poliza
Boton=7
NombreEnBoton=S
NombreDesplegar=Generar &Póliza
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
Activo=S
Visible=S
GuardarAntes=S
ClaveAccion=Aceptar
Antes=S
AntesExpresiones=ProcesarSQL(<T>spEmpresaParticipacionGenerar :tEmpresa, :nSuc, :tUsr, :fFecha<T>, Empresa, Sucursal, Usuario, FechaTrabajo)
DespuesGuardar=S

[Lista.EmpresaParticipacion.UltimoCambio]
Carpeta=Lista
Clave=EmpresaParticipacion.UltimoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Lista.EmpresaParticipacion.Moneda]
Carpeta=Lista
Clave=EmpresaParticipacion.Moneda
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar
Guardar=Actualizar
Actualizar=Poliza
Poliza=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=EmpresaParticipacion.Simbolo
EmpresaParticipacion.Simbolo=EmpresaParticipacion.Descripcion
EmpresaParticipacion.Descripcion=EmpresaParticipacion.Resultado
EmpresaParticipacion.Resultado=EmpresaParticipacion.Moneda
EmpresaParticipacion.Moneda=EmpresaParticipacion.UltimoCambio
EmpresaParticipacion.UltimoCambio=(Fin)
