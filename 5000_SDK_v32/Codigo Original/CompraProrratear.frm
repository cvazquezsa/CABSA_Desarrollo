[Forma]
Clave=CompraProrratear
Nombre=Prorratear en Base a Movimiento
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=400
PosicionInicialArriba=285
PosicionInicialAltura=198
PosicionInicialAncho=223
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
EsMovimiento=S
TituloAuto=S
MovModulo=COMS
MovEspecificos=Todos
ExpresionesAlMostrar=Asigna(Info.BaseProrrateo, Nulo)<BR>Asigna(Info.Importe, Nulo)<BR>Asigna(Info.PorcentajeImpuesto, General.DefImpuesto)<BR>Asigna(Info.Mov, Nulo)<BR>Asigna(Info.MovID, Nulo)

[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Variables).Info.BaseProrrateo]
Carpeta=(Variables)
Clave=Info.BaseProrrateo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Importe]
Carpeta=(Variables)
Clave=Info.Importe
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[(Variables).Info.PorcentajeImpuesto]
Carpeta=(Variables)
Clave=Info.PorcentajeImpuesto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Controles Captura
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Asignar<BR>Aceptar

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[(Variables).Info.Mov]
Carpeta=(Variables)
Clave=Info.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=18
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.MovID]
Carpeta=(Variables)
Clave=Info.MovID
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=9
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
ConCondicion=S
EjecucionConError=S
Visible=S
EjecucionCondicion=Asigna(Temp.Num, SQL(<T>SELECT ID FROM Compra WHERE Empresa =:tEmpresa AND Mov = :tMov AND MovID =:tMovID AND Estatus NOT IN (<T>+Comillas(EstatusSinAfectar)+<T>, <T>+Comillas(EstatusCancelado)+<T>)<T>, Empresa, Info.Mov, Info.MovID))<BR>Si<BR>  ConDatos(Temp.Num) y ConDatos(Info.BaseProrrateo)<BR>Entonces<BR>  ProcesarSQL(<T>spCompraProratearAplica :nID, :tBase, :nImporte, :nPorcentaje, :nAplicaID<T>, Info.ID, Info.BaseProrrateo, Info.Importe, Info.PorcentajeImpuesto, Temp.Num)<BR>  Verdadero<BR>Sino<BR>  Falso<BR>Fin
EjecucionMensaje=<T>Movimiento Incorrecto<T>

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.Mov
Info.Mov=Info.MovID
Info.MovID=Info.BaseProrrateo
Info.BaseProrrateo=Info.Importe
Info.Importe=Info.PorcentajeImpuesto
Info.PorcentajeImpuesto=(Fin)
