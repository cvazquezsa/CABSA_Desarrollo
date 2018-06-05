[Forma]
Clave=GRP_PresupuestoD
Nombre=Detalle
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=283
PosicionInicialArriba=342
PosicionInicialAlturaCliente=312
PosicionInicialAncho=713
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Totalizadores=S
PosicionSeccion1=87
Comentarios=Lista(Info.Cuenta, MonetarioEnTexto(Info.Importe))

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GRP_PresupuestoD
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
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaMantenerSeleccion=S
FiltroGeneral=GRP_PresupuestoD.ID={Info.ID}

[Lista.GRP_PresupuestoD.Periodo]
Carpeta=Lista
Clave=GRP_PresupuestoD.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GRP_PresupuestoD.Importe]
Carpeta=Lista
Clave=GRP_PresupuestoD.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GRP_PresupuestoD.Reduccion]
Carpeta=Lista
Clave=GRP_PresupuestoD.Reduccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.GRP_PresupuestoD.Ampliacion]
Carpeta=Lista
Clave=GRP_PresupuestoD.Ampliacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Neto]
Carpeta=Lista
Clave=Neto
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Lista.Columnas]
Periodo=42
Importe=121
Reduccion=125
Ampliacion=133
Neto=120
PeriodoNombre=128

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Suma(GRP_PresupuestoD:Neto)=Info.Importe
EjecucionMensaje=<T>No Corresponden los Totales<T>
EjecucionConError=S

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

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Lista.PeriodoNombre]
Carpeta=Lista
Clave=PeriodoNombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=PPEF<BR>Reducciones<BR>Ampliaciones<BR>Total PEF
Totalizadores2=Suma(GRP_PresupuestoD:GRP_PresupuestoD.Importe)<BR>Suma(GRP_PresupuestoD:GRP_PresupuestoD.Reduccion)<BR>Suma(GRP_PresupuestoD:GRP_PresupuestoD.Ampliacion)<BR>Suma(GRP_PresupuestoD:Neto)
Totalizadores3=(Monetario)<BR>(Monetario)<BR>(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Carpeta Totalizadores).Total PEF]
Carpeta=(Carpeta Totalizadores)
Clave=Total PEF
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[(Carpeta Totalizadores).PPEF]
Carpeta=(Carpeta Totalizadores)
Clave=PPEF
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Reducciones]
Carpeta=(Carpeta Totalizadores)
Clave=Reducciones
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Totalizadores).Ampliaciones]
Carpeta=(Carpeta Totalizadores)
Clave=Ampliaciones
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Asistente]
Nombre=Asistente
Boton=12
NombreDesplegar=Asistente
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Wizards
ClaveAccion=Asistente Presupuestos
ListaParametros1=<BR><BR>GRP_PresupuestoD:GRP_PresupuestoD.Periodo<BR>GRP_PresupuestoD:GRP_PresupuestoD.Importe
ListaParametros=S
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.NivelCuenta]
Nombre=NivelCuenta
Boton=47
NombreEnBoton=S
NombreDesplegar=&Nivel Cuenta
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=GRP_PresupuestoCta
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(GRP_PresupuestoD:GRP_PresupuestoD.Periodo)
AntesExpresiones=Asigna(Info.Periodo, GRP_PresupuestoD:GRP_PresupuestoD.Periodo)<BR>Asigna(Info.Importe2, GRP_PresupuestoD:GRP_PresupuestoD.Importe)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Asistente
Asistente=NivelCuenta
NivelCuenta=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=GRP_PresupuestoD.Periodo
GRP_PresupuestoD.Periodo=PeriodoNombre
PeriodoNombre=GRP_PresupuestoD.Importe
GRP_PresupuestoD.Importe=GRP_PresupuestoD.Reduccion
GRP_PresupuestoD.Reduccion=GRP_PresupuestoD.Ampliacion
GRP_PresupuestoD.Ampliacion=Neto
Neto=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=PPEF
PPEF=Reducciones
Reducciones=Ampliaciones
Ampliaciones=Total PEF
Total PEF=(Fin)
