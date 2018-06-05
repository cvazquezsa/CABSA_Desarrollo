[Forma]
Clave=BPlanAsisteNom
Icono=0
Modulos=(Todos)
Nombre=Asistente Nómina
ListaCarpetas=BPlanAsisteNom
CarpetaPrincipal=BPlanAsisteNom
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=413
PosicionInicialArriba=436
PosicionInicialAlturaCliente=118
PosicionInicialAncho=454
ListaAcciones=(Lista)

[BPlanAsisteNom]
Estilo=Ficha
Clave=BPlanAsisteNom
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=BPlanAsisteNom
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
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
FiltroGeneral=BPlanAsisteNom.Estacion = {EstacionTrabajo}

[BPlanAsisteNom.BPlanAsisteNom.Ejercicio]
Carpeta=BPlanAsisteNom
Clave=BPlanAsisteNom.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[BPlanAsisteNom.BPlanAsisteNom.Inc]
Carpeta=BPlanAsisteNom
Clave=BPlanAsisteNom.Inc
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[BPlanAsisteNom.BPlanAsisteNom.Inc2]
Carpeta=BPlanAsisteNom
Clave=BPlanAsisteNom.Inc2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[BPlanAsisteNom.BPlanAsisteNom.Inc3]
Carpeta=BPlanAsisteNom
Clave=BPlanAsisteNom.Inc3
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[BPlanAsisteNom.BPlanAsisteNom.Usar]
Carpeta=BPlanAsisteNom
Clave=BPlanAsisteNom.Usar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Aceptar.SQL]
Nombre=SQL
Boton=0
TipoAccion=Expresion
Expresion=ProcesarSQL(<T>spBPlanSugiereNom :ntEstacion, :tEmpresa, :tModulo, :tUsuario, :tMon<T>, EstacionTrabajo, Empresa, Info.Modulo, Usuario, Info.Moneda)
Activo=S
Visible=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Aceptar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Aceptar<BR>SQL
Activo=S
Visible=S
NombreEnBoton=S
GuardarAntes=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[BPlanAsisteNom.ListaEnCaptura]
(Inicio)=BPlanAsisteNom.Ejercicio
BPlanAsisteNom.Ejercicio=BPlanAsisteNom.Inc
BPlanAsisteNom.Inc=BPlanAsisteNom.Inc2
BPlanAsisteNom.Inc2=BPlanAsisteNom.Inc3
BPlanAsisteNom.Inc3=BPlanAsisteNom.Usar
BPlanAsisteNom.Usar=(Fin)
