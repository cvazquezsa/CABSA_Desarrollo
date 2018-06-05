[Forma]
Clave=CtePresupuesto
Nombre=Cuota por Cliente / Sucursal          
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=227
PosicionInicialArriba=271
PosicionInicialAlturaCliente=454
PosicionInicialAncho=825
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtePresupuesto
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
ValidarCampos=S
ListaCamposAValidar=Cte.Nombre

[Lista.CtePresupuesto.Cliente]
Carpeta=Lista
Clave=CtePresupuesto.Cliente
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtePresupuesto.EnviarA]
Carpeta=Lista
Clave=CtePresupuesto.EnviarA
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtePresupuesto.Familia]
Carpeta=Lista
Clave=CtePresupuesto.Familia
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtePresupuesto.Cantidad]
Carpeta=Lista
Clave=CtePresupuesto.Cantidad
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtePresupuesto.Importe]
Carpeta=Lista
Clave=CtePresupuesto.Importe
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtePresupuesto.ImporteAjustado]
Carpeta=Lista
Clave=CtePresupuesto.ImporteAjustado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Cliente=79
Nombre=167
Ejercicio=64
Periodo=64
EnviarA=80
Familia=123
Cantidad=71
Importe=121
ImporteAjustado=109
Nombre_1=122
Agente=83

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

[Lista.CteEnviarA.Nombre]
Carpeta=Lista
Clave=CteEnviarA.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CteEnviarA.Agente]
Carpeta=Lista
Clave=CteEnviarA.Agente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a E&xcel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CtePresupuesto.Cliente
CtePresupuesto.Cliente=CtePresupuesto.EnviarA
CtePresupuesto.EnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.Agente
CteEnviarA.Agente=CtePresupuesto.Familia
CtePresupuesto.Familia=CtePresupuesto.Cantidad
CtePresupuesto.Cantidad=CtePresupuesto.Importe
CtePresupuesto.Importe=CtePresupuesto.ImporteAjustado
CtePresupuesto.ImporteAjustado=(Fin)
